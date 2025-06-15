<script setup lang="ts">
import { vAutoAnimate } from '@formkit/auto-animate/vue'
import { toTypedSchema } from '@vee-validate/zod'
import { useForm } from 'vee-validate'
import * as z from 'zod'

const formSchema = toTypedSchema(z.object({
  id: z.string(),
  files: z
    .any()
    .refine((files) => Array.isArray(files) && files.length > 0, {
      message: 'At least one file must be selected',
    }),
}))

const { handleSubmit } = useForm({
  validationSchema: formSchema,
})

const onSubmit = handleSubmit(values => {
  console.log('Form submitted with values:', values)
  // Handle form submission logic here
})
</script>

<template>
  <div class="flex items-center justify-center h-screen">
    <div class="w-3/4 max-w-md">
      <Form class=" w-2/3 space-y-6" @submit="onSubmit" v-auto-animate>
        <FormField v-slot="{ componentField }" name="id">
          <FormItem v-auto-animate>
            <FormLabel>Media ID</FormLabel>
            <FormControl>
              <Input type="text" placeholder="shadcn" v-bind="componentField" />
            </FormControl>
            <FormDescription>
              The Post ID
            </FormDescription>
            <FormMessage />
          </FormItem>
        </FormField>
        <FormField v-slot="{ componentField }" name="files">
          <FormItem v-auto-animate>
            <FormLabel>Files</FormLabel>
            <FormControl>
              <Input type="file" v-bind="componentField" />
            </FormControl>
            <FormDescription>
              Select files to upload
            </FormDescription>
            <FormMessage />
          </FormItem>
        </FormField>
        <Button type="submit">
          Submit
        </Button>
      </Form>
    </div>
  </div>
</template>