require 'benchmark'
require "pry"

=begin
Usage
$> ruby main.rb "password_string"
=end
class PasswordChecker
  attr_reader :password_string
  VALID_MES = "パスワードがだめっぽいです。\n".freeze
  VALID_RULE = {
    number_include: { reg: /\d+/, mes: "数字が含まれていません\n" },
    lower_include: { reg: /[a-z]+/, mes: "小文字が含まれていません\n" },
    upper_include: { reg: /[A-Z]+/, mes: "大文字が含まれていません\n" },
    enough_length: { reg: /.{8,}/, mes: "既定の文字数に達していません\n" },
  }.freeze
  OPTION_MES = "よさそうなパスワードです！ よきかな\n".freeze
  OPTION_RULE = {
    valid_symbol: { reg: /[!"#$%&'\(\)*+,-.\/\\:;<=>?@\[\]^_`{|}~]+/, mes: "記号が含まれています！ Good\n" },
    start_with_symbol: { reg: /\A[^\w]/, mes: "記号から始まっています！ Great！\n" },
  }.freeze

  def initialize(password_string)
    @password_string = password_string
  end

  def run
    check
  end

  def check
    error_messages = checker(VALID_RULE)
    return VALID_MES + error_messages if error_messages.present?
    oneup_messages = checker(OPTION_RULE)
    OPTION_MES + oneup_messages
  end

  def checker(rule)
    rule.each.with_object("") do |key, mes|
      mes << rule[key][:mes]
    end
  end
end

puts PasswordChecker.new(ARGV[0]).run
