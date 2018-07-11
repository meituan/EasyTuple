module Fastlane
  module Actions
    class CodecovAction < Action
      def self.run(params)
        cmd = ['curl -s https://codecov.io/bash | bash']

        cmd << "-s --" if params.all_keys.inject(false) { |p, k| p or params[k] }
        cmd << "-X xcodeplist" if params[:use_xcodeplist]
        cmd << "-J '#{params[:project_name]}'" if params[:project_name]
        cmd << "-t '#{params[:token]}'" if params[:token]

        sh cmd.join(" ")
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Upload your coverage files to Codecov"
      end

      def self.details
        "https://codecov.io"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :use_xcodeplist,
                                       env_name: "FL_CODECOV_USE_XCODEPLIST",
                                       description: "[BETA] Upload to Codecov using xcodeplist",
                                       is_string: false,
                                       default_value: false,),
          FastlaneCore::ConfigItem.new(key: :project_name,
                                       env_name: "FL_CODECOV_PROJECT_NAME",
                                       description: "Upload to Codecov using a project name",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :token,
                                       env_name: "FL_CODECOV_TOKEN",
                                       description: "API token for private repos",
                                       optional: true),
        ]
      end

      def self.author
        "Flávio Caetano (@fjcaetano)"
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
