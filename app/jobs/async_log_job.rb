class AsyncLogJob < ApplicationJob
  queue_as do
    case self.arguments.first[:message]
    when "to async_log"
      :async_log
    else
      :default
    end
  end

  retry_on StandardError, wait: 5.seconds, attempts: 3

  discard_on ZeroDivisionError do |job, error|
    SomeNotifier.push(error)
  end

  def perform(message: "hello")
    AsyncLog.create!(message: message)
  end
end