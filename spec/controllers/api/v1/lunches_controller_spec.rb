require 'rails_helper'

RSpec.describe Api::V1::LunchesController, 'Routes', type: :routing do
  it 'should route to' do
    is_expected.to route(:get, '/api/v1/lunches').to(action: 'index')
    is_expected.to route(:get, '/api/v1/lunches/1').to(action: 'show', id: 1)
    is_expected.to route(:post, '/api/v1/lunches').to(action: 'create')
    is_expected.to route(:patch, '/api/v1/lunches/1').to(action: 'update', id: 1)
    is_expected.to route(:delete, '/api/v1/lunches/1').to(action: 'destroy', id: 1)
  end
end

RSpec.describe Api::V1::LunchesController, type: :controller do
  let(:parsed_response) { JSON.parse(response.body) }

  describe 'GET #index' do
    let(:params) { {} }
    let!(:lunch) { create(:lunch) }
    let!(:lunches) { create_list(:lunch, 9) }
    let!(:user) { create(:user) }

    subject { get :index, params: params }

    context 'with NO authentication header' do
      it { expect(subject).to have_http_status(:unauthorized) }
    end

    context 'with authentication header' do
      before do
        request.headers.merge!(authenticated_header(user))
        subject
      end
      context 'with lunches' do
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
        lunch: attributes_for(:lunch)
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

      context 'for employees' do
        let!(:user) { create(:user, :employee) }

        it 'should respond with' do
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to eq 'application/json; charset=utf-8'
        end
      end
    end
  end
end
