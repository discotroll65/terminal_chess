class ChessError < StandardError
end

class NoPieceError < ChessError
end

class IllegalMoveError < ChessError
end

class IntoCheckError < ChessError
end

class NotChessNotation < ChessError
end

class NotYourTurn < ChessError
end
