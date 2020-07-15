describe 'business intelligence' do
  it 'can get merchants with most revenue' do
    # get "/api/v1/merchants/most_revenue?quantity=7"
    # json = JSON.parse(response.body, symbolize_names: true)
    #
    # expect(json[:data].length).to eq(7)
    #
    # expect(json[:data][0][:attributes][:name]).to eq("Dicki-Bednar")
    # expect(json[:data][0][:id]).to eq("14")
    #
    # expect(json[:data][3][:attributes][:name]).to eq("Bechtelar, Jones and Stokes")
    # expect(json[:data][3][:id]).to eq("10")
    #
    # expect(json[:data][6][:attributes][:name]).to eq("Rath, Gleason and Spencer")
    # expect(json[:data][6][:id]).to eq("53")
  end
end
