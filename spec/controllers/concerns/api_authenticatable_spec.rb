require "rails_helper"

describe APIAuthenticatable do
  let(:dummy_class) do
    Class.new(ApplicationController) do
      include APIAuthenticatable
      attr_accessor :params, :api_key
    end
  end

  context "instances" do
    subject { dummy_class.new }
    it { expect(subject).to be_an_instance_of(dummy_class) }
    it { is_expected.to be_a(APIAuthenticatable) }

    describe "#api_authenticate!" do
      it { is_expected.to respond_to(:api_authenticate!)}
      it "should return true if skip?" do
        subject.params = {}
        subject.params[:api_auth_skip] = 1
        expect(subject.api_authenticate!).to be_truthy
        expect(subject.send(:skip?)).to be_truthy
      end
      it "should false unless skip?" do
        subject.params = {}
        subject.params[:api_auth_skip] = false
        expect(subject.send(:skip?)).to be_falsey
      end

      it "should return true if api token created" do
        token = create_api_token
        subject.params = {}
        subject.params[:api_key] = token.access_id
        req_dbl = double("Request")
        expect(req_dbl).to receive(:host).and_return(token.hostname)
        expect(req_dbl).to receive(:protocol).and_return("http://")
        expect(subject).to receive(:request).at_least(2).times.and_return(req_dbl)
        expect(subject).to receive_message_chain(:response, :headers ).and_return({})
        expect(subject.send(:set_cors_headers)).to be_truthy
      end

      it "should work with https too" do
        token = create_api_token
        subject.params = {}
        subject.params[:api_key] = token.access_id
        req_dbl = double("Request")
        expect(req_dbl).to receive(:host).and_return(token.hostname)
        expect(req_dbl).to receive(:protocol).and_return("https://")
        expect(subject).to receive(:request).at_least(2).times.and_return(req_dbl)
        expect(subject).to receive_message_chain(:response, :headers ).and_return({})
        expect(subject.send(:set_cors_headers)).to be_truthy
      end
    end
  end
end