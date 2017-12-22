=begin
Usage
$> ruby main.rb "password_string"
=end
class PasswordChecker
  attr_reader :password_string
  VALID_MES = "パスワードがだめっぽいです。"
  VALID_RULE = {
    number_include: { reg: /\d+/, mes: "数字が含まれていません" },
    lower_include: { reg: /[a-z]+/, mes: "小文字が含まれていません" },
    upper_include: { reg: /[A-Z]+/, mes: "大文字が含まれていません" },
    enough_length: { reg: /.{8,}/, mes: "既定の文字数に達していません" },
  }.freeze
  OPTION_MES = "よさそうなパスワードです！ よきかな"
  OPTION_RULE = {
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
    errors = []
    oneup = []

    VALID_RULE.each do |key, rule|
      errors << rule[:mes] unless password_string.match(rule[:reg])
    end
    return errors.unshift(VALID_MES).join("\n") if errors[0]

    OPTION_RULE.each do |key, rule|
      oneup << rule[:mes] if password_string.match(rule[:reg])
    end
    oneup.uniq.unshift(OPTION_MES).join("\n")
  end
end
