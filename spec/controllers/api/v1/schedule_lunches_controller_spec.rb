require 'rails_helper'

RSpec.describe Api::V1::ScheduleLunchesController, 'Routes', type: :routing do
  it 'should route to' do
    is_expected.to route(:get, '/api/v1/schedule_lunches').to(action: 'index')
    is_expected.to route(:get, '/api/v1/schedule_lunches/1').to(action: 'show', id: 1)
    is_expected.to route(:post, '/api/v1/schedule_lunches').to(action: 'create')
    is_expected.to route(:patch, '/api/v1/schedule_lunches/1').to(action: 'update', id: 1)
    is_expected.to route(:delete, '/api/v1/schedule_lunches/1').to(action: 'destroy', id: 1)
  end
end

RSpec.describe Api::V1::ScheduleLunchesController, type: :controller do
  let(:parsed_response) { JSON.parse(response.body) }

  describe 'GET #index' do
    let(:params) { {} }
    let!(:user) { create(:user) }
    let!(:schedule_lunch) { create(:schedule_lunch, user: user) }
    let!(:schedule_lunches) { create_list(:schedule_lunch, 9, user: user) }
    let!(:another_schedules) { create_list(:schedule_lunch, 5) }

    subject { get :index, params: params }

    context 'with NO authentication header' do
      it { expect(subject).to have_http_status(:unauthorized) }
    end

    context 'with authentication header' do
      before do
        request.headers.merge!(authenticated_header(user))
        subject
      end
      context 'with schedules' do
        it 'should respond with' do
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to eq 'application/json; charset=utf-8'
          expect(parsed_response).not_to be_nil
          expect(parsed_response.size).to eq 10
          expect(parsed_response).not_to be_empty
        end
      end
    end
  end

  describe 'POST #create' do
    let!(:lunch) { create(:lunch) }
    let(:params) do
      {
        schedule_lunch: attributes_for(:schedule_lunch).merge({ lunch_id: lunch.id })
      }
    end
    let!(:user) { create(:user) }

    subject { post :create, params: params }

    context 'with NO authentication header' do
      it { expect(subject).to have_http_status(:unauthorized) }
    end

    context 'with authentication header' do
      before do
        request.headers.merge!(authenticated_header(user))
        subject
      end

      it 'should respond with' do
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq 'application/json; charset=utf-8'
        expect(parsed_response).not_to be_nil
        expect(parsed_response['id']).not_to be_nil
      end
    end
  end
end
