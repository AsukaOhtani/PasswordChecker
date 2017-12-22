require "spec_helper"

describe PasswordChecker do
  describe "run" do
    subject { PasswordChecker.new(password_string).run }
    let(:error_mes) { "パスワードがだめっぽいです。" }
    let(:no_upper) { "大文字が含まれていません" }
    let(:no_lower) { "小文字が含まれていません" }
    let(:no_int) { "数字が含まれていません" }
    let(:no_length) { "既定の文字数に達していません" }
    let(:success_mes) { "よさそうなパスワードです！ よきかな" }
    let(:start_with_sym) { "記号から始まっています！ Great！" }
    let(:included_sym) { "記号が含まれています！ Good" }

    context "str: blank" do
      let(:password_string) { "" }
      it {
        str = [error_mes, no_int, no_lower, no_upper, no_length].join("\n")
        is_expected.to eq str
      }
    end

    context "str: included upper char" do
      let(:password_string) { "ABC" }
      it {
        str = [error_mes, no_int, no_lower, no_length].join("\n")
        is_expected.to eq str
      }
    end

    context "str: included upper & lower char" do
      let(:password_string) { "ABCabc" }
      it {
        str = [error_mes, no_int, no_length].join("\n")
        is_expected.to eq str
      }
    end

    context "str: included upper & lower & int char" do
      let(:password_string) { "ABab12" }
      it {
        str = [error_mes, no_length].join("\n")
        is_expected.to eq str
      }
    end

    context "str: included upper & lower & int char & 8 > str" do
      let(:password_string) { "ABCabc123" }
      it {
        str = [success_mes].join("\n")
        is_expected.to eq str
      }
    end

    context "str: success_password & include symbol" do
      let(:password_string) { "ABC-abc-123" }
      it {
        str = [success_mes, included_sym].join("\n")
        is_expected.to eq str
      }
    end

    context "str: success_password & start with symbol" do
      let(:password_string) { "@ABC-abc-123" }
      it {
        str = [success_mes, included_sym, start_with_sym].join("\n")
        is_expected.to eq str
      }
    end
  end
end
