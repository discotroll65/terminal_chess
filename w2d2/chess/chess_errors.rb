class ChessError < StandardError
end

class NoPieceError < ChessError
end

class IllegalMoveError < ChessError
end

class IntoCheckError < ChessError
end
