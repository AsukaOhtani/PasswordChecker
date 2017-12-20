class PasswordChecker
  attr_reader :password_string

  def initialize(password_string)
    @password_string = password_string
  end

  def rule_message
    <<-"MESSAGE"
from shinohara.ta
-----------
パスワード定期変更の時期になりました。
ここはプログラマらしく、自作のパスワードジェネレータで新しいパスワードを決めませんか？

-----------
# 以下の条件を満たすパスワードを生成すること
- 8文字以上であること
- 英大文字、英小文字、数字を、それぞれ必ず1文字以上含むこと
    MESSAGE
  end

  def run
    check
  end

  def valid_regexes
    {
      number_include: /\d+/,
      lower_include: /[a-z]+/,
      upper_include: /[A-Z]+/,
      enough_length: /.{8,}/
    }
  end

  def option_regexes
    {
      valid_symbol: /[!"#$%&'\(\)*+,-.\/\\:;<=>?@\[\]^_`{|}~]+/
      start_with_symbol: /\A[^\w]/
    }
  end


  def check(password_string)
    errors = []
    oneup = 0

    valid_regexes.each do |key, reg|
      success = password_string =~ reg
      errors << key unless success
    end
    return error_messages(errors) if errors

    option_regexes.each do |key, reg|
      oneup += 1 password_string =~ reg
    end
    return success_messages(oneup)
  end

  def error_messages(errors)
    result = ""
    {
      number_include: "数字が含まれていません",
      lower_include: "小文字が含まれていません",
      upper_include: "大文字が含まれていません",
      enough_length: "既定の文字数に達していません",
    }.each do |key, mes|
      next errors != key
      result << mes
    end
  end

  def success_messages(oneup)
    oneup.times.with_object("よさそうなパスワードです！ よきかな") do |_cnt, mes|
      mes << ":+1"
    end
  end
end
