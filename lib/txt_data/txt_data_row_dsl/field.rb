require 'txt_data/format_helpers'

module TxtData::TxtDataRowDSL
  Field = Struct.new(:symbol, :range, :just, :pad, :value, :format, :sanitize) do
    include TxtData::FormatHelpers

    def to_s(record)
      data = get_data(record)
      validate_length!(data)
      format_data data
    end

    private

    def format_data(data)
      case format
      when :text
        format_text(data, sanitize: sanitize)
      when :number
        number_format(data, length: range.size, just: just, pad: pad)
      when :money
        money_format(data, length: range.size, just: just, pad: pad)
      else
        # :nocov:
        raise ArgumentError, "Unsupported format #{format}"
        # :nocov:
      end
    end

    def validate_length!(data)
      #Do not use .blank?  we need to match ' ' for pad.
      if (pad.nil? || pad.empty?) && data.length != range.size
        # :nocov:
        raise ArgumentError, "Data #{data} is not the correct length for field #{symbol}"
        # :nocov:
      end
    end

    def get_data(record)
      value || record.public_send(symbol)
    end

    def format_text(data, sanitize:)
      text_format(data.to_s, length: range.size, just: just, pad: pad, sanitize: sanitize)
    end
  end
end
