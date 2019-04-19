module Swars
  module Crawler
    # Swars::Crawler::ExpertCrawler.new(page_max: 3, sleep: 5).run
    class ExpertCrawler < Base
      def default_params
        {
          user_keys: Rails.env.production? ? Rails.application.credentials[:expert_import_user_keys] : ["devuser1"],
          sleep: Rails.env.production? ? 4 : 0,
          page_max: Rails.env.production? ? 256 : 1,
        }
      end

      def perform
        params[:user_keys].each do |user_key|
          difference_report_for(user_key) do
            Battle.user_import(params.merge(user_key: user_key))
          end
        end
      end
    end
  end
end
