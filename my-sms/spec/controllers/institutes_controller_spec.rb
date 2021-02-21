# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InstitutesController, type: :controller do
  let!(:institute) { create(:institute) }

  describe 'GET #index' do
    subject { get :index }
    it 'returns a success response' do
      is_expected.to be_success
      is_expected.to render_template('index')
    end
  end

  describe 'GET #show' do
    subject { get :show, { id: institute.to_param } }
    it 'returns a success response' do
      is_expected.to be_success
      is_expected.to render_template('show')
    end
  end

  describe 'GET #new' do
    subject { get :new }
    it 'returns a success response' do
      is_expected.to be_success
      is_expected.to render_template('new')
    end
  end

  describe 'GET #edit' do
    subject { get :edit, { id: institute.to_param } }
    it 'returns a success response' do
      is_expected.to be_success
      is_expected.to render_template('edit')
    end
  end

  describe 'POST #create' do
    subject { post :create, { institute: institute } }

    context 'with valid params' do
      let(:institute) { attributes_for(:institute) }

      it 'creates a new Institute' do
        expect { subject }.to change(Institute, :count).by(1)
      end

      it 'redirects to the created institute' do
        is_expected.to be_redirect
        is_expected.to redirect_to(Institute.last)
      end
    end

    context 'with invalid params' do
      let(:institute) { attributes_for(:institute, name: nil) }

      it "returns a success response (i.e. to display the 'new' template)" do
        is_expected.to be_success
        is_expected.to render_template('new')
      end

      it 'does not create a new record' do
        expect { subject }.to_not change(Institute, :count)
      end
    end
  end

  describe 'PUT #update' do
    let!(:institute) { create(:institute) }
    subject { put :update, { id: institute.to_param, institute: new_attributes } }

    context 'with valid params' do
      let(:new_attributes) do
        attributes_for(:institute, { name: 'Updated name' })
      end
      let(:attr_names) { %w[name] }
      let(:new_attr_values) { new_attributes.stringify_keys.fetch_values(*attr_names) }

      it 'updates the requested institute' do
        expect { subject }.to change {
          institute.reload.attributes.fetch_values(*attr_names)
        }.to(new_attr_values)
      end

      it 'redirects to the institute' do
        is_expected.to be_redirect
        is_expected.to redirect_to(institute)
      end
    end

    context 'with invalid params' do
      let(:new_attributes) do
        attributes_for(:institute, { name: nil })
      end

      it "returns a success response (i.e. to display the 'edit' template)" do
        is_expected.to be_success
        is_expected.to render_template('edit')
      end

      it 'should propagate model errors to an error flash' do
        expect { subject }.to change { flash[:error] }.from(nil).to(["Name can't be blank"])
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:institute) { create(:institute) }
    subject { delete :destroy, { id: institute.to_param } }

    it 'destroys the requested institute' do
      expect { subject }.to change(Institute, :count).by(-1)
    end

    it 'redirects to the institutes list' do
      should be_redirect
      should redirect_to(institutes_url)
    end
  end
end
