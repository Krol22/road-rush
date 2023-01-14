local function reversedipairsiter(t, i)
    i = i - 1
    if i ~= 0 then
        return i, t[i]
    end
end

function Reversedipairs(t)
    return reversedipairsiter, t, #t + 1
end

return Reversedipairs
