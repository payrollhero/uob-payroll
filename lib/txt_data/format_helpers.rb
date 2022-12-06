module TxtData
  # A helpful module for formatting fields for fixed length txt data files.
  module FormatHelpers
    # Right justified, "0" padded, 2 decimal places, with no separator.
    # @param [Fixnum] value
    # @param [Fixnum] length
    def money_format(value, length:, just: :right, pad: '0')
      txt = ("%.2f" % value.round(2)).to_s.sub(".", "").truncate(length, omission: "")
      justify(txt, length, just, pad)
    end

    # Right justified, "0" padded, no decimal places, with no separator.
    # @param [Fixnum] value
    # @param [Fixnum] length
    # @param [Symbol] just
    # @param [String] pad
    def number_format(value, length:, just: :right, pad: '0')
      txt = value.to_i.to_s.truncate(length, omission: "")
      justify(txt, length, just, pad)
    end

    # Left justified, " " padded, text.
    # @param [String] value
    # @param [Fixnum] length
    # @param [Symbol] just
    # @param [String] pad
    def text_format(value, length:, just: :left, sanitize:, pad: ' ')
      txt = sanitize ? filter_illegal_characters(value.to_s).truncate(length, omission: "") : value
      justify(txt, length, just, pad)
    end

    # Filters invalid characters specified in CPF eSubmission spec file.
    # @param [String] value
    def filter_illegal_characters(value)
      value.tr("-_+$<>:;?!=[]`^|\\'\"`~", "")
    end

    private

    def justify(txt, length, just, pad)
      case just
      when :left
        txt.ljust(length, pad)
      when :right
        txt.rjust(length, pad)
      else
        # :nocov:
        raise ArgumentError, "Justification #{just} is not supported."
        # :nocov:
      end
    end
  end
end
