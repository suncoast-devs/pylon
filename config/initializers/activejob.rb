# Configure Rails to use the Async adapter but only process one job at a time
# This sould be fine for production at this point but we could/should switch
# to something like sidekiq when we can
Rails.config.active_job.queue_adapter = ActiveJob::QueueAdapters::AsyncAdapter.new(
  min_threads: 1,
  max_threads: 1,
  idletime: 60.seconds
)