# frozen_string_literal: true

require 'spec_helper'

RSpec.describe EnotasApi::V1::CancelarNfs do
  let(:empresa_id) { '123' }
  let(:nfs_id) { '123' }
  let(:instance) { described_class.new(empresa_id, nfs_id) }

  it 'have expected uri' do
    expect(instance.uri).to eq("/v1/empresas/#{empresa_id}/nfes/#{nfs_id}")
  end

  it 'have expected method' do
    expect(instance.method).to eq(:DELETE)
  end
end
