require 'spec_helper'

describe Api::V1::FormsController do
  describe "GET #show" do
    before(:each) do
      @form = FactoryGirl.create :form
      get :show, id: @form.id
    end

    it "returns the information about a reporter on a hash" do
      form_response = json_response
      expect(form_response[:name]).to eql @form.name
    end

    it { should respond_with 200 }
  end

  describe "GET #index" do
    before(:each) do
      4.times { FactoryGirl.create :form }
      get :index
    end

    it "returns 4 records from the database" do
      forms_response = json_response
      expect(forms_response[:forms]).to have(4).items
    end

    it { should respond_with 200 }
  end

end
