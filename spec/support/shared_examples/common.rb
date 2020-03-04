# frozen_string_literal: true

RSpec.shared_examples 'a regular #index action' do
  context 'when subject exists' do
    before do
      get "/#{endpoint[:name]}", headers: headers
    end

    it "returns list of subjects" do
      expect(parsed_response.first.key?("errors")).to be_falsey
      expect(parsed_response).not_to be_empty
    end

    it 'returns status 200' do
      expect(response).to have_http_status(200)
    end
  end

  context "when subject does not exists" do
    before { DatabaseCleaner.clean }
    it 'returns status 404' do
      get "/#{endpoint[:name]}", headers: headers

      expect(parsed_response).to be_empty
    end
  end
end

RSpec.shared_examples 'a regular #show action' do
  context 'when subject exists' do
    before do
      get "/#{endpoint[:name]}/#{endpoint_subject[:id]}", headers: headers
    end

    it "returns subject" do
      expect(parsed_attributes[attribute[:name]]).to eq(attribute[:content])
    end

    it 'returns status 200' do
      expect(response).to have_http_status(200)
    end
  end

  context "when subject does not exists" do
    it 'returns status 404' do
      get "/#{endpoint[:name]}/1000", headers: headers

      expect(response).to have_http_status(404)
    end
  end
end

RSpec.shared_examples 'a regular #create action' do
  before do
    post "/#{endpoint[:name]}",
         params: endpoint_subject_params.to_json, headers: headers
  end

  context 'when request params are valid' do
    let(:endpoint_subject_params) { FactoryBot.attributes_for(endpoint_subject[:name].to_sym) }

    it 'returns status 201 created' do
      expect(response).to have_http_status(201)
    end
    it 'returns json with created user data' do
      expect(parsed_attributes[attribute[:name]]).to eq(attribute[:content])
    end
  end

  context 'when request params are not valid' do
    let(:endpoint_subject_params) do
      FactoryBot.attributes_for(endpoint_subject[:name].to_sym,
                                "#{attribute[:name]}": attribute[:invalid_content])
    end

    it 'response has status unprocessable_entity' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns json with errors' do
      expect(parsed_response).to have_key('errors')
    end
  end
end

RSpec.shared_examples 'a regular #put action' do
  before do
    put "/#{endpoint[:name]}/#{endpoint_subject[:id]}",
        params: endpoint_subject_params.to_json, headers: headers
  end

  context 'when request params are valid' do
    let(:endpoint_subject_params) do
      { id: endpoint_subject[:id],
        "#{attribute[:name]}": attribute[:content] }
    end

    it 'returns status 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns json with updated user data' do
      expect(parsed_attributes[attribute[:name]]).to eq(attribute[:content])
    end
  end

  context 'when request params are not valid' do
    let(:endpoint_subject_params) do
      { id: endpoint_subject[:id],
        "#{attribute[:name]}": attribute[:invalid_content] }
    end

    it 'returns status 422' do
      expect(response).to have_http_status(422)
    end
  end
end

RSpec.shared_examples 'a regular #delete action' do
  before do
    delete "/#{endpoint[:name]}/#{endpoint_subject[:id]}",
           params: endpoint_subject_params.to_json, headers: headers
  end

  context 'when request params are valid' do
    let(:endpoint_subject_params) { { id: endpoint_subject[:id] } }
    it 'returns status 204' do
      expect(response).to have_http_status(204)
    end

    # rubocop:disable Security/Eval
    # rubocop:disable Style/EvalWithLocation
    it 'user is deleted for good' do
      expect(
        eval("#{class_name}.find_by(id: endpoint_subject[:id])")
      ).to be_nil
    end
    # rubocop:enable Style/EvalWithLocation
    # rubocop:enable Security/Eval
  end
end
