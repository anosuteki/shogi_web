module AtomicScript
  concern :SupportMod do
    def bold(str)
      h.tag.b(str)
    end

    def small(str)
      h.tag.small(str)
    end
  end
end
