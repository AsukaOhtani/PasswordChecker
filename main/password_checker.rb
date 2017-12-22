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
      errors << key unless password_string =~ rule[:reg]
    end
    return error_messages(errors) if errors[0]

    OPTION_RULE.each do |key, rule|
      oneup << key if password_string =~ rule[:reg]
    end
    return success_messages(oneup)
  end

  def error_messages(errors)
    errors.each.with_object(VALID_MES) do |key, mes|
      mes << "\n#{VALID_RULE[key][:mes]}"
    end
  end

  def success_messages(oneup)
    oneup.each.with_object(OPTION_MES) do |key, mes|
      mes << "\n#{OPTION_RULE[key][:mes]}"
    end
  end
end
