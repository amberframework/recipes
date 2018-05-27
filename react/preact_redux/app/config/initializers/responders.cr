# HACK: delete after https://github.com/amberframework/amber/pull/774 is merged
module Amber::Controller::Helpers
  module Responders
    alias ProcType = Proc(String) | Proc(Int32)

    class Content
      @available_responses = Hash(String, String | ProcType).new
      @body : String | Int32 | Nil = nil

      # TODO: add JS type similar to rails.
      def html(html : String | ProcType)
        @available_responses[TYPE[:html]] = html; self
      end

      def xml(xml : String | ProcType)
        @available_responses[TYPE[:xml]] = xml; self
      end

      def json(json : String | ProcType | Hash(Symbol | String, String))
        if json.is_a?(Proc)
          @available_responses[TYPE[:json]] = json
        else
          @available_responses[TYPE[:json]] = json.is_a?(String) ? json : json.to_json
        end
        self
      end

      def text(text : String | ProcType)
        @available_responses[TYPE[:text]] = text; self
      end

      def body
        @body ||= begin
          case _body = @available_responses[type]?
          when Proc
            _body.call
          else
            _body
          end
        end
      end
    end

    def set_response(body, status_code = 200, content_type = Content::TYPE[:html])
      if context.response.status_code == 200
        context.response.status_code = status_code
      else
        Amber.logger.error "Setting response status_code would overwrite previous value"
      end
      context.response.content_type = content_type
      context.content = body
    end

    protected def respond_with(status_code = 200, &block)
      content = with Content.new(requested_responses) yield
      if content.body
        set_response(body: content.body.to_s, status_code: status_code, content_type: content.type)
      else
        set_response(body: "Response Not Acceptable.", status_code: 406, content_type: Content::TYPE[:text])
      end
    end
  end
end
