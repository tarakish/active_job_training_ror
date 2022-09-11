require "test_helper"
class AsyncLogJobTest < ActiveJob::TestCase
  test 'Enqueue AsyncLogJob' do
    assert_enqueued_with(job: AyncLogJob) do
      AsyncLogJob.perform_later(message: 'from tedst')
    end
  end
end
