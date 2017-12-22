require "yaml"
=begin
Usage
$> ruby main.rb "password_string"
=end
class PasswordChecker
  attr_reader :password_string
  SETTING = YAML.load_file(File.join(File.dirname(__FILE__), "..", "config", "settings.yml")).freeze

  def initialize(password_string)
    @password_string = password_string
  end

  def run
    check
  end

  def check
    checker(valid_message, valid_rules) || checker(option_message, option_rules)
  end

  def checker(mes, rules)
    array = []
    rules.each do |key, rule|
      array << rule["mes"] if password_string.match(rule["reg"])
    end
    array[0] ? array.reject(&:empty?).unshift(mes).join("\n") : nil
  end

  private

  def valid_message
    SETTING["valid"]["first_message"]
  end

  def valid_rules
    SETTING["valid"]["rules"]
  end

  def option_message
    SETTING["option"]["first_message"]
  end

  def option_rules
    SETTING["option"]["rules"]
  end
end
