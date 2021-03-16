<template>
  <div class="max-w-md m-auto py-10">
    <div class="text-red-400" v-if="error">{{ error }}</div>
    <h3 class="font-mono font-regular text-3xl mb-4">Add a new task</h3>
    <form action="" @submit.prevent="addTask">
      <div class="mb-6">
        <input class="input"
          type="text"
          autofocus autocomplete="off"
          placeholder="Task title"
          v-model="newTask.title" />
      </div>
      <div class="mb-6">
        <input class="input"
          type="text"
          autocomplete="off"
          placeholder="Task description"
          v-model="newTask.description" />
      </div>
      <div class="mb-6">
        <input class="input"
          type="date"
          autocomplete="off"
          placeholder="Task description"
          v-model="newTask.due_date" />
      </div>
      <div class="mb-6">
        <select class="input" name="priority" placeholder="Priority" id="priority" v-model="newTask.priority">
          <option value="High">High</option>
          <option value="Moderate">Moderate</option>
          <option value="Low">Low</option>
        </select>
      </div>
      <input type="submit" value="Add Task" class="font-sans font-bold px-4 rounded cursor-pointer no-underline bg-green-400 hover:bg-green-500 block w-full py-4 text-white items-center justify-center" />
    </form>

    <hr class="border border-gray-100 my-6" />

    <ul class="list-reset mt-4">
      <li class="py-4" v-for="task in tasks" :key="task.id" :task="task">

        <div class="w-full justify-center py-6 px-3 mx-auto">
                <div class="bg-white shadow-xl rounded-lg overflow-hidden">

                    <div class="p-4">
                        <p class="uppercase tracking-wide text-sm font-bold text-gray-700">{{ task.due_date }}</p>
                        <p class="text-3xl text-gray-900">{{ task.title }}</p>
                        <p class="text-gray-700">{{ task.description }}</p>
                    </div>
                    <div class="flex justify-between p-4 border-t border-gray-300 text-gray-700">
                        <div class="flex-1 inline-flex justify-center items-center">
                            <button class="bg-tranparent text-sm hover:bg-green-400 hover:text-white text-green-400 border border-green-400 no-underline font-bold py-2 px-4 mr-2 rounded"
                            @click.prevent="editTask(task)">Done</button>
                        </div>
                        <div class="flex-1 inline-flex justify-center items-center">
                            <button class="bg-tranparent text-sm hover:bg-blue-400 hover:text-white text-blue-400 border border-blue-400 no-underline font-bold py-2 px-4 mr-2 rounded"
                            @click.prevent="editTask(task)">Edit</button>
                        </div>
                        <div class="flex-1 inline-flex justify-center items-center">
                            <button class="bg-transprent text-sm hover:bg-red-400 text-red-400 hover:text-white no-underline font-bold py-2 px-4 rounded border border-red-400"
                            @click.prevent="removeTask(task)">Delete</button>
                        </div>
                    </div>
                </div>
            </div>

        <div v-if="task == editedTask">
          <form action="" @submit.prevent="updateTask(task)">
            <div class="mb-6 p-4 bg-white rounded border border-grey-light mt-4">
              <input class="input" v-model="task.title" />
              <input type="submit" value="Update" class=" my-2 bg-transparent text-sm hover:bg-blue hover:text-white text-blue border border-blue no-underline font-bold py-2 px-4 rounded cursor-pointer">
            </div>
          </form>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: 'Tasks',
  data () {
    return {
      tasks: [],
      newTask: {},
      error: '',
      editedTask: {}
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/tasks')
        .then(response => { this.tasks = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    addTask () {
      const value = this.newTask
      if (!value) {
        return
      }
      this.$http.secured.post('/api/v1/tasks/',
        {
          task: {
            title: this.newTask.title,
            description: this.newTask.description,
            due_date: this.newTask.due_date,
            priority: this.newTask.priority
          }
        })
        .then(response => {
          this.tasks.push(response.data)
          this.newTask = ''
          this.error = ''
        })
        .catch(error => this.setError(error, 'Cannot create task'))
    },
    removeTask (task) {
      this.$http.secured.delete(`/api/v1/tasks/${task.id}`)
        .then(response => {
          this.tasks.splice(this.tasks.indexOf(task), 1)
        })
        .catch(error => this.setError(error, 'Cannot delete task'))
    },
    editTask (task) {
      this.editedTask = task
    },
    updateTask (task) {
      this.editedTask = ''
      this.$http.secured.patch(`/api/v1/tasks/${task.id}`, { task: { title: task.name } })
        .catch(error => this.setError(error, 'Cannot update task'))
    }
  }
}
</script>
