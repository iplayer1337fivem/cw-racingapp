<template>
  <div id="ResultsPage" class="pagecontent">
    <v-tabs v-model="tab">
      <v-tab value="results">Race Results</v-tab>
      <v-tab value="records">Race Records</v-tab>
    </v-tabs>

    <v-window v-model="tab">
      <v-window-item value="results" class="tabcontent">
        <RaceResults v-if="allResults" :allResults="allResults"></RaceResults>
        <InfoText v-else title="No data" />
      </v-window-item>
      <v-window-item value="records" class="tabcontent">
        <RaceRecords v-if="allRecords" :allRecords="allRecords"></RaceRecords>
        <InfoText v-else title="No data" />
      </v-window-item>
    </v-window>
  </div>
</template>

<script setup lang="ts">
import api from "@/api/axios";
import { useGlobalStore } from "@/store/global";
import { Ref, onMounted, ref } from "vue";
import RaceResults from "../components/RaceResults.vue";
import { Track, ResultData } from "@/store/types";
import RaceRecords from "../components/RaceRecords.vue";
import InfoText from "../components/InfoText.vue";

const allResults: Ref<ResultData[] | undefined> = ref(undefined);
const allRecords: Ref<Track[] | undefined> = ref(undefined);
const globalStore = useGlobalStore();
const tab = ref(globalStore.currentPage);

const getResults = async () => {
  const response = await api.post("UiGetRacingResults");
  if (response.data) allResults.value = response.data
};
const getRecords = async () => {
  const response = await api.post("UiGetTracks");
  if (response.data) allRecords.value = response.data
};

onMounted(() => {
  getResults();
  getRecords();
});

</script>

<style scoped lang="scss"></style>
