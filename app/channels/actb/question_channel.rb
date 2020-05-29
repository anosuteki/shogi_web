module Actb
  class QuestionChannel < BaseChannel
    def subscribed
      raise ArgumentError, params.inspect unless question_id
      stream_from "actb/question_channel/#{question_id}"

      unless current_user
        reject
      end
    end

    def unsubscribed
    end

    def speak(data)
      data = data.to_options
      if data[:message].start_with?("/")
        execution_interrupt_hidden_command(data[:message])
      else
        current_question.messages.create!(user: current_user, body: data[:message])
      end
    end

    def execution_interrupt_hidden_command(str)
      if md = str.to_s.match(/\/(?<command_line>.*)/)
        args = md["command_line"].split
        command = args.shift
        Rails.logger.debug(["#{__FILE__}:#{__LINE__}", __method__, command, args])
        if command == "foo"
        end
      end
    end

    private

    def question_id
      params["question_id"]
    end

    def current_question
      Question.find(question_id)
    end
  end
end
