<template>
  <div class="max-w-md m-auto py-10">
    <div class="text-red-400" v-if="error">{{ error }}</div>
    <h3 class="font-mono font-regular text-3xl mb-4">Add a new task</h3>
    <form action="" @submit.prevent="addTask">
      <div class="mb-6">
        <input
          class="input"
          type="text"
          autofocus
          autocomplete="off"
          placeholder="Task title"
          v-model="newTask.title"
        />
      </div>
      <div class="mb-6">
        <input
          class="input"
          type="text"
          autocomplete="off"
          placeholder="Task description"
          v-model="newTask.description"
        />
      </div>
      <div class="mb-6">
        <input
          class="input"
          type="date"
          autocomplete="off"
          placeholder="Task description"
          v-model="newTask.due_date"
        />
      </div>
      <div class="mb-6">
        <select
          class="input"
          name="priority"
          placeholder="Priority"
          id="priority"
          v-model="newTask.priority"
        >
          <option value="High">High</option>
          <option value="Moderate">Moderate</option>
          <option value="Low">Low</option>
        </select>
        <!-- <input class="input"
          type="text"
          autocomplete="off"
          placeholder="Task priority"
          v-model="newTask.priority" /> -->
      </div>
      <input
        type="submit"
        value="Add Task"
        class="font-sans font-bold px-4 rounded cursor-pointer no-underline bg-green-400 hover:bg-green-500 block w-full py-4 text-white items-center justify-center"
      />
    </form>
  </div>
</template>

<script>
export default {};
</script>

<style>
</style>
