# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotesController, type: :controller do
  let!(:note) { create(:note) }

  describe 'GET #show' do
    subject { get :show, { id: note.to_param } }
    it 'returns a success response' do
      is_expected.to be_success
      is_expected.to render_template('show')
    end
  end

  describe 'POST #create' do
    subject { post :create, { note: note, **notable_params } }
    let(:notable) { create(:student) }
    let(:notable_params) { { student_id: notable.to_param, notable_type: 'Student' } }

    context 'with valid params (on a student)' do
      let(:note) { attributes_for(:note) }

      it 'creates a new Note' do
        expect { subject }.to change(Note, :count).by(1)
      end

      it 'redirects to the notable' do
        is_expected.to be_redirect
        is_expected.to redirect_to(notable)
      end
    end

    context 'with invalid params' do
      let(:note) { attributes_for(:note, title: nil) }

      it 'redirects to the notable' do
        is_expected.to be_redirect
        is_expected.to redirect_to(notable)
      end

      it 'does not create a new record' do
        expect { subject }.to_not change(Note, :count)
      end

      it 'should propagate model errors to an error flash' do
        expect { subject }.to change { flash[:error] }.from(nil).to(["Title can't be blank"])
      end
    end
  end

  describe 'PUT #update' do
    let!(:note) { create(:note) }
    subject { put :update, { id: note.to_param, note: new_attributes } }

    context 'with valid params' do
      let(:new_attributes) do
        attributes_for(:note, { title: 'New note', content: 'Note content' })
      end

      let(:attr_names) { %w[title content] }
      let(:new_attr_values) { new_attributes.stringify_keys.fetch_values(*attr_names) }

      it 'updates the requested note' do
        expect { subject }.to change {
          note.reload.attributes.fetch_values(*attr_names)
        }.to(new_attr_values)
      end

      it 'redirects to the note' do
        is_expected.to be_redirect
        is_expected.to redirect_to(note)
      end
    end

    context 'with invalid params' do
      let(:new_attributes) do
        attributes_for(:note, title: nil)
      end

      it 'redirects to the notable' do
        is_expected.to be_redirect
        is_expected.to redirect_to(note.notable)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:note) { create(:note) }
    subject { delete :destroy, { id: note.to_param } }

    it 'destroys the requested note' do
      expect { subject }.to change(Note, :count).by(-1)
    end

    it 'redirects to the notes list' do
      should be_redirect
      should redirect_to(notes_url)
    end
  end
end
