# frozen_string_literal: true

require_relative '../common/request'

module EnotasApi
  module V1
    class ConsultarNotaFiscalIdExterno < EnotasApi::Request
      def initialize(empresa_id, id_externo)
        @empresa_id = empresa_id
        @id_externo = id_externo
        super()
      end

      def uri
        "/v1/empresas/#{url_encode(@empresa_id)}/nfes/porIdExterno/#{url_encode(@id_externo)}"
      end
    end
  end
end
