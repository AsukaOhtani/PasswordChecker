require 'benchmark'
require "pry"

=begin
Usage
$> ruby main.rb "password_string"
=end
class PasswordChecker
  attr_reader :password_string

  def initialize(password_string)
    @password_string = password_string
  end

  def run
    check
  end

  def valid_regexes
    {
      number_include: { reg: /\d+/, mes: "数字が含まれていません\n" },
      lower_include: { reg: /[a-z]+/, mes: "小文字が含まれていません\n" },
      upper_include: { reg: /[A-Z]+/, mes: "大文字が含まれていません\n" },
      enough_length: { reg: /.{8,}/, mes: "既定の文字数に達していません\n" },
    }
  end

  def option_regexes
    {
      valid_symbol: { reg: /[!"#$%&'\(\)*+,-.\/\\:;<=>?@\[\]^_`{|}~]+/, mes: "記号が含まれています！ Good\n" },
      start_with_symbol: { reg: /\A[^\w]/, mes: "記号から始まっています！ Great！\n" },
    }
  end

  def check
    errors = []
    oneup = []

    valid_regexes.each do |key, rule|
      errors << key unless password_string =~ rule[:reg]
    end
    return error_messages(errors) if errors[0]

    option_regexes.each do |key, rule|
      oneup << key if password_string =~ rule[:reg]
    end
    return success_messages(oneup)
  end

  def error_messages(errors)
    result = ""
    errors.each.with_object("パスワードがだめっぽいです。\n") do |key, mes|
      mes << valid_regexes[key][:mes]
    end
  end

  def success_messages(oneup)
    oneup.each.with_object("よさそうなパスワードです！ よきかな\n") do |key, mes|
      mes << option_regexes[key][:mes]
    end
  end
end

puts PasswordChecker.new(ARGV[0]).run