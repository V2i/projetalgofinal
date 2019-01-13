import Foundation

public struct ChampDeBatailleStruct : ChampDeBatailleProtocol {
    public typealias Position = PositionStruct
    public typealias Carte = CarteStruct
    public typealias CollectionDeCartes = CollectionDeCartesStruct



    internal var positionT : [Position]

    public init(){
        self.positionT = []
        self.positionT.append(Position(nom : NomPosition.F1, carte : nil))
        self.positionT.append(Position(nom : NomPosition.F2, carte : nil))
        self.positionT.append(Position(nom : NomPosition.F3, carte : nil))
        self.positionT.append(Position(nom : NomPosition.A1, carte : nil))
        self.positionT.append(Position(nom : NomPosition.A2, carte : nil))
        self.positionT.append(Position(nom : NomPosition.A3, carte : nil))
    }

    public func estvideCDB() -> Bool {
    	var res = true
        for pos in self.positionT {
            if !pos.estPositionVide() {
                res = false
            }
        }
        return res
    }

    public func estPlein() -> Bool {
    	var res = true
        for pos in self.positionT {
            if pos.estPositionVide() {
                res = false
            }
        }
        return res
    }

    public mutating func ajouterCarteCDB(carte : Carte, position : Position, main : inout CollectionDeCartes) -> ChampDeBatailleStruct {
        var index = 0
        for pos in self.positionT {
            if pos.getNomPos() == position.getNomPos() {
                if let testcarte = position.getCarte() { //s'il y a deja une carte sur le board on fait l'echange des 2 cartes
                    self = self.enleverCarteCDB(position : position)
                    main = main.ajouterCarteCollection(carte : testcarte)
                }
                self.positionT[index] = Position(nom : pos.getNomPos(), carte : carte)
            }
            index += 1
        }
        return self
    }

    public mutating func enleverCarteCDB(position : Position) -> ChampDeBatailleStruct {
        if let _ = position.getCarte() {
            var index = 0
            for pos in self.positionT {
                if pos.getNomPos() == position.getNomPos() {
                    self.positionT[index] = Position(nom : pos.getNomPos(), carte : nil)
                }
                index += 1
            }
        }
        return self
    }

    public func getCarteCDB(position : Position) -> Carte? {
        if let carte = position.getCarte() {
            return carte
        }
        else {
            return nil
        }
    }

    // public func makeIterator() -> ItCDB{
    //     return ItCDB(cdb : self)
    // }

    public mutating func reinitCartes() -> ChampDeBatailleStruct {
        var index = 0
        for pos in self.positionT {
            if let carte = pos.getCarte() { //s'il n'y pas de carte, on ne fait rien 
                var newcarte = carte
                self.positionT[index] = Position(nom : pos.getNomPos(), carte : newcarte.reinitCarte())
            }
            index += 1
        }
        return self
    }

    public func estPosDef() -> Bool {
        var res = true
        for pos in self.positionT {
            if let carte = pos.getCarte() {
                if !pos.estPositionVide() && !carte.getEstPositionDef() {
                    res = false
                }
            }
        }
        return res
    }

    public mutating func mettrePositionOffensive(pos : Position) -> ChampDeBatailleStruct {
        if let carte = pos.getCarte() {
            var index = 0
            for posi in self.positionT {
                if posi.getNomPos() == pos.getNomPos() {
                    var newcarte = carte
                    self.positionT[index] = Position(nom : posi.getNomPos(), carte : newcarte.mettrepositionOff())
                }
                index += 1
            }
        }
        return self
    }

    public mutating func subirattaque(carteA : Carte, posSubie : Position) -> ChampDeBatailleStruct {
        var index = 0
        for pos in self.positionT {
            if pos.getNomPos() == posSubie.getNomPos() {
                if let temp = self.positionT[index].getCarte() { //si la position possede une carte
                    var carte : Carte = temp
                    if carte.getEstPositionDef() { //si la carte est en position de deffense 
                        if carte.getnbdegats() == 0 && carte.getnbdefenseendefense() == carteA.getValAtq() { //si la carte se fait detruire en un seul coup on l'ajoute au royaume adverse
                            self.positionT[index] = Position(nom : pos.getNomPos(), carte : carte.setnbdegats(val : 0))
                            self = self.enleverCarteCDB(position : posSubie)
                            //ajouter a la carte detruite au royaume du joueur attaquant /!\
                        }else {
                            self.positionT[index] = Position(nom : pos.getNomPos(), carte : carte.setnbdegats(val : carte.getnbdegats() + carteA.getValAtq()))
                            if carte.getnbdefenseendefense() <= carte.getnbdegats() + carteA.getValAtq() { //si la carte a subie trop de degats on l'enleve du champ de bataille
                                self.positionT[index] = Position(nom : pos.getNomPos(), carte : carte.setnbdegats(val : 0))
                                self = self.enleverCarteCDB(position : posSubie)
                            }
                        }
                    } else { //si la carte est en position d'attaque
                        if carte.getnbdegats() == 0 && carte.getnbdefenseenattaque() == carteA.getValAtq() { //si la carte se fait detruire en un seul coup on l'ajoute au royaume adverse
                            self.positionT[index] = Position(nom : pos.getNomPos(), carte : carte.setnbdegats(val : 0))
                            self = self.enleverCarteCDB(position : posSubie)
                            //ajouter a la carte detruite au royaume du joueur attaquant /!\
                        }else {
                            self.positionT[index] = Position(nom : pos.getNomPos(), carte : carte.setnbdegats(val : carte.getnbdegats() + carteA.getValAtq()))
                            if carte.getnbdefenseenattaque() <= carte.getnbdegats() + carteA.getValAtq() { //si la carte a subie trop de degats on l'enleve du champ de bataille
                                self.positionT[index] = Position(nom : pos.getNomPos(), carte : carte.setnbdegats(val : 0))
                                self = self.enleverCarteCDB(position : posSubie)
                            }
                        }
                    } 
                }
            }
            index += 1
        }
        return self
    }



}

// public struct ItCDB : IteratorProtocol {

//     fileprivate var indexCourant : Int = 0
//     fileprivate var positionC : PositionStruct? = nil
//     fileprivate var cdb : [PositionStruct]

//     init(cdb : ChampDeBatailleStruct) {
//         self.cdb = cdb.positionT
//         positionC = self.cdb[indexCourant]
//     }

//     public mutating func next() -> PositionStruct? {
//         let tmp = positionC
//         indexCourant+=1
//         if indexCourant > 6 {
//             positionC = nil
//         }
//         else {
//             positionC = self.cdb[indexCourant]

//         }
//         return tmp
//     }
// }
