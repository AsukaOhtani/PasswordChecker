=begin
Usage
$> ruby main.rb "password_string"
=end
class PasswordChecker
  attr_reader :password_string
  VALID_MES = "パスワードがだめっぽいです。"
  VALID_RULE = {
    number_include: { reg: /^(([^\d])+|)$/, mes: "数字が含まれていません" },
    lower_include: { reg: /^(([^a-z])+|)$/, mes: "小文字が含まれていません" },
    upper_include: { reg: /^(([^A-Z])+|)$/, mes: "大文字が含まれていません" },
    enough_length: { reg: /^(.{0,7})$/, mes: "既定の文字数に達していません" },
  }.freeze
  OPTION_MES = "よさそうなパスワードです！ よきかな"
  OPTION_RULE = {
    no_special: { reg: /.*/, mes: "" },
    valid_symbol: { reg: /[!"#$%&'\(\)*+,-.\/\\:;<=>?@\[\]^_`{|}~]+/, mes: "記号が含まれています！ Good" },
    start_with_symbol: { reg: /\A[^\w]/, mes: "記号から始まっています！ Great！" },
  }.freeze

  def initialize(password_string)
    @password_string = password_string
  end

  def run
    check
  end

  def check
    checker(VALID_MES, VALID_RULE) || checker(OPTION_MES, OPTION_RULE)
  end

  def checker(mes, rules)
    array = []
    rules.each do |key, rule|
      array << rule[:mes] if password_string.match(rule[:reg])
    end
    array[0] ? array.reject(&:empty?).unshift(mes).join("\n") : nil
  end
end
