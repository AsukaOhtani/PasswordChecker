require "spec_helper"

describe PasswordChecker do
  describe "run" do
    subject { PasswordChecker.new(password_string).run }
    let(:error_mes) { "パスワードがだめっぽいです。" }
    let(:no_upper) { "大文字が含まれていません" }
    let(:no_lower) { "小文字が含まれていません" }
    let(:no_int) { "数字が含まれていません" }
    let(:no_length) { "既定の文字数に達していません" }

    context "str: blank" do
      let(:password_string) { "" }
      it {
        str = [error_mes, no_int, no_lower, no_upper, no_length].join("\n") + "\n"
        is_expected.to eq str
      }
    end
  end
end
