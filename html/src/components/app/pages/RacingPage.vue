<template>
  <div id="RacingPage" class="pagecontent">
    <v-tabs v-model="tab" v-if="tab !== 'setup2'" v-on:update:model-value="fetchRelevantData()">
      <v-tab value="current">Current</v-tab>
      <v-tab value="available">Available</v-tab>
      <v-tab value="setup">Setup</v-tab>
    </v-tabs>
    <v-window v-model="tab">
      <v-window-item value="current" class="tabcontent">
        <div class="current-race-container page-container">
          <div id="current-race-selection" v-if="currentRace">
            <CurrentRaceCard
              :race="currentRace"
              @leave="leaveRace()"
              @start="startRace()"
            ></CurrentRaceCard>
          </div>
          <div id="current-race-none" v-else>
            <h3 class="inline centered">No race active</h3>
          </div>
        </div>
      </v-window-item>
      <v-window-item value="available" class="tabcontent">
        <div class="subheader">
          <h3>Available Races</h3>
          <v-btn variant="text" @click="getListedRaces"> Refresh </v-btn>
        </div>
        <div
          v-if="isLoading"
          class="loading-container"
          id="available-races-loader"
        >
          <span class="loader"></span>
        </div>
        <div v-else class="available-races">
          <AvailableRacesCard
            v-for="race in races"
            :race="race"
          ></AvailableRacesCard>
        </div>
      </v-window-item>
      <v-window-item value="setup" class="tabcontent">
        <div class="subheader">
          <h3 class="header-text">Pick A Track</h3>
            <v-switch
              v-model="globalStore.showOnlyCurated"
              hide-details
              density="compact"
            >
              <template #label>
                {{
                  globalStore.showOnlyCurated
                    ? "Showing curated tracks"
                    : "Showing all tracks"
                }}
              </template>
            </v-switch>
          <v-text-field
            class="text-field"
            hideDetails
            placeholder="Search..."
            density="compact"
            v-model="search"
          ></v-text-field>
        </div>
        <div
          v-if="isLoading"
          class="loading-container"
          id="available-races-loader"
        >
          <span class="loader"></span>
        </div>
        <div v-else class="available-races">
          <AvailableTracksCard
            v-for="track in filteredTracks"
            :track="track"
            @select="(track) => selectTrack(track)"
          ></AvailableTracksCard>
        </div>
      </v-window-item>
    </v-window>
  </div>
  <SetupRaceDialog
    v-if="selectedTrack"
    :open="!!selectedTrack"
    :track="selectedTrack"
    @goBack="resetTrackSetup()"
  ></SetupRaceDialog>
</template>

<script setup lang="ts">
import api from "@/api/axios";
import { useGlobalStore } from "@/store/global";
import { Ref, ref } from "vue";
import AvailableRacesCard from "../items/AvailableRacesCard.vue";
import AvailableTracksCard from "../items/AvailableTracksCard.vue";
import CurrentRaceCard from "../items/CurrentRaceCard.vue";
import SetupRaceDialog from "../components/SetupRaceDialog.vue";
import { onMounted } from "vue";
import { CurrentRace, Track } from "@/store/types";
import { closeApp } from "@/helpers/closeApp";
import { computed } from "vue";

const globalStore = useGlobalStore();
const tab = ref(globalStore.currentPage);
const isLoading = ref(false);
const races = ref([]);
const dialog = ref(false);
const search = ref('');
const selectedTrack: Ref<Track | undefined> = ref(undefined);
const currentRace: Ref<CurrentRace | undefined> = ref(undefined);

const filteredTracks = computed(() => {
  let tracks = globalStore.tracks;
  if (globalStore.showOnlyCurated)
    tracks = tracks.filter((track: Track) => !!track.Curated);
  if (tracks && search.value !== '') tracks = tracks.filter((track) => track.RaceName.toLowerCase().includes(search.value.toLowerCase()) || track.RaceId.toLowerCase().includes(search.value.toLowerCase()) )

  return tracks.sort((a: Track, b: Track) =>
    a.RaceName.toLowerCase() > b.RaceName.toLowerCase() ? 1 : -1
  );
});

const resetTrackSetup = () => {
  tab.value = "setup";
  selectedTrack.value = undefined;
};

const getListedRaces = async () => {
  isLoading.value = true;
  const res = await api.post("UiGetListedRaces");
  races.value = res.data;
  isLoading.value = false;
};

const selectTrack = (track: Track) => {
  dialog.value = true;
  selectedTrack.value = track;
};

const getTracks = async () => {
  isLoading.value = true
  const res = await api.post("UiGetAvailableTracks");
  globalStore.$state.tracks = res.data;
  isLoading.value = false
};

const getCurrent = async () => {
  const res = await api.post("UiFetchCurrentRace");
  if (res.data.raceId) currentRace.value = res.data
};

const leaveRace = async () => {
  if (currentRace?.value?.raceId) {
    await api.post("UiLeaveCurrentRace", JSON.stringify(currentRace.value.raceId));
    currentRace.value = undefined
  }
};

const startRace = async () => {
  if (currentRace?.value?.raceId) {
    await api.post("UiStartCurrentRace", JSON.stringify(currentRace.value.raceId));
    currentRace.value = undefined
    closeApp()
  }
};

const fetchRelevantData = () => {
  if (tab.value === 'current') getCurrent();
  else if (tab.value === 'setup') getTracks();
  else if (tab.value === 'available') getListedRaces();
}

onMounted(() => {
  getCurrent();
  selectedTrack.value = undefined;
});
</script>

<style scoped lang="scss">
.available-races {
  display: flex;
  flex-wrap: wrap;
  gap: 1em;
  margin-top: 1em;
}
</style>
