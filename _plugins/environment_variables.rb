# Plugin to load environment variables into Jekyll configuration
# Works locally and in GitHub Actions

module Jekyll
  class EnvironmentVariablesGenerator < Generator
    safe true
    priority :highest

    def generate(site)
      # Load .env file if it exists (for local development only)
      env_file = File.join(site.source, '.env')
      if File.exist?(env_file)
        File.foreach(env_file) do |line|
          line.strip!
          next if line.empty? || line.start_with?('#')
          
          key, value = line.split('=', 2)
          if key && value
            ENV[key.strip] = value.strip
          end
        end
      end

      # Replace environment variable placeholders in config
      replace_env_vars(site.config)
    end

    private

    def replace_env_vars(obj)
      case obj
      when Hash
        obj.each do |key, value|
          obj[key] = replace_env_vars(value)
        end
      when Array
        obj.map! { |item| replace_env_vars(item) }
      when String
        # Replace ${VAR_NAME} with actual environment variable
        obj.gsub(/\$\{([^}]+)\}/) do |match|
          var_name = $1
          ENV[var_name] || match
        end
      else
        obj
      end
    end
  end
end