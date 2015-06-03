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

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        @form_attributes = FactoryGirl.attributes_for :form
        api_authorization_header user.auth_token
        post :create, { user_id: user.id, form: @form_attributes }
      end

      it "renders the json representation for the form record just created" do
        form_response = json_response
        expect(form_response[:name]).to eql @form_attributes[:name]
      end

      it { should respond_with 201 }
   end

   context "when is not created" do
     before(:each) do
      user = FactoryGirl.create :user
      @invalid_form_attributes = { name: "Smart TV" }
      api_authorization_header user.auth_token
      post :create, { user_id: user.id, form: @invalid_form_attributes }
    end

    it "renders an errors json" do
      form_response = json_response
      expect(form_response).to have_key(:errors)
    end

    it "renders the json errors on why the form could not be created" do
      form_response = json_response
      expect(form_response[:errors][:body]).to include "can't be blank"
    end

    it { should respond_with 422 }
  end
 end

 describe "PUT/PATCH #update" do
   before(:each) do
    @user = FactoryGirl.create :user
    @form = FactoryGirl.create :form, user: @user
    api_authorization_header @user.auth_token
   end

   context "when is successfully updated" do
     before(:each) do
      patch :update, { user_id: @user.id, id: @form.id,
                        form: { name: "Ian's Form"} }
     end

     it "renders the json representation for the updated form" do
       form_response = json_response
       expect(form_response[:name]).to eql "Ian's Form"
     end

     it { should respond_with 200 }
   end
end

end
