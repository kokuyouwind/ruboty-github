module Ruboty
  module Handlers
    class Github < Base
      env :GITHUB_HOST, "Pass GitHub Host if needed (e.g. github.example.com)", optional: true

      on(
        /create issue "(?<title>.+)" on (?<repo>.+)(?:\n(?<description>[\s\S]+))?\z/,
        name: "create_issue",
        description: "Create a new issue",
      )

      on(
        /remember my github token (?<token>.+)\z/,
        name: "remember",
        description: "Remember sender's GitHub access token",
      )

      on(
        /close issue (?<repo>.+)#(?<number>\d+)\z/,
        name: "close_issue",
        description: "Close an issue",
      )

      on(
        /pull request "(?<title>.+)" from (?<from>.+) to (?<to>.+)(?:\n(?<description>[\s\S]+))?\z/,
        name: "create_pull_request",
        description: "Create a pull request",
      )

      on(
        /merge (?<repo>.+)#(?<number>\d+)\z/,
        name: "merge_pull_request",
        description: "Merge pull request",
      )

      on(
        /create branch "(?<name>.+)" from (?<from>.+)/,
        name: "create_branch",
        description: "Create branch"
      )

      on(
        /push branch (?<repo>\S+) (?<name>.+) from (?<from>.+)/,
        name: "push_branch",
        description: "Push branch"
      )

      on(
        /push force branch (?<repo>\S+) (?<name>.+) from (?<from>.+)/,
        name: "push_force_branch",
        description: "Push force branch"
      )

      on(
        /prepare (?<name>\S+) (?<repo>\S+)( (?<branch>\S+))?/,
        name: 'prepare_deploy',
        description: 'prepare deploy branch'
      )

      on(
        /release (?<name>\S+) (?<repo>\S+)( (?<branch>\S+))?/,
        name: 'prepare_release',
        description: 'prepare release branch'
      )

      on(
        /release_with_env (?<name>\S+) (?<repo>\S+)( (?<branch>\S+))?/,
        name: 'prepare_release_with_env',
        description: 'prepare release branch(env/xxx)'
      )

      on(
        %r{.*https?://github\.com/(?<repo>.*)/pull/(?<number>\d+).*},
        name: "show_pull_request",
        description: "show pull request",
        all: true
      )

      on(
        /show undeployed (?<repo>.*)/,
        name: 'show_undeployed_pull_requests',
        description: 'show undeployed pull requests'
      )

      def create_issue(message)
        Ruboty::Github::Actions::CreateIssue.new(message).call
      end

      def close_issue(message)
        Ruboty::Github::Actions::CloseIssue.new(message).call
      end

      def remember(message)
        Ruboty::Github::Actions::Remember.new(message).call
      end

      def create_pull_request(message)
        Ruboty::Github::Actions::CreatePullRequest.new(message).call
      end

      def merge_pull_request(message)
        Ruboty::Github::Actions::MergePullRequest.new(message).call
      end

      def create_branch(message)
        Ruboty::Github::Actions::CreateBranch.new(message).call
      end

      def push_branch(message)
        Ruboty::Github::Actions::PushBranch.new(message).call
      end

      def push_force_branch(message)
        Ruboty::Github::Actions::PushBranch.new(message, force: true).call
      end

      def prepare_deploy(message)
        Ruboty::Github::Actions::Deploy.new(message, 'deployment').call
      end

      def prepare_release(message)
        Ruboty::Github::Actions::Deploy.new(message, 'release').call
      end

      def prepare_release_with_env(message)
        Ruboty::Github::Actions::Release.new(message, 'release', 'release').call
      end

      def show_pull_request(message)
        Ruboty::Github::Actions::ShowPullRequest.new(message).call
      end

      def show_undeployed_pull_requests(message)
        Ruboty::Github::Actions::ShowUndeployedPullRequests.new(message).call
      end
    end
  end
end
