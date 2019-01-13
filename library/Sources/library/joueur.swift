import Foundation 

public struct JoueurStruct : JoueurProtocol {
    public typealias Position = PositionStruct
    public typealias CollectionDeCartes = CollectionDeCartesStruct
    public typealias ChampDeBataille = ChampDeBatailleStruct
    public typealias Carte = CarteStruct

	internal var nomjoueur : String
    internal var main : CollectionDeCartes
    internal var royaume : CollectionDeCartes
    internal var pioche : CollectionDeCartes
    internal var cimetiere : CollectionDeCartes
    internal var cdb : ChampDeBataille

    public init(nom: String){
    	self.nomjoueur = nom
    	self.main = CollectionDeCartes()
    	self.cimetiere = CollectionDeCartes()
    	self.royaume = CollectionDeCartes()
    	self.pioche = CollectionDeCartes()
    	self.cdb = ChampDeBataille()
    }

    public func getNom() -> String {
    	return self.nomjoueur
    }

    public func getMain() -> CollectionDeCartes {
    	return self.main
    }

    public func getCimetiere() -> CollectionDeCartes {
    	return self.cimetiere
    }

    public func getRoyaume() -> CollectionDeCartes {
    	return self.royaume
    }

    public func getPioche() -> CollectionDeCartes {
    	return self.pioche
    }

    public func getCdB() -> ChampDeBataille {
    	return self.cdb
    }

    public mutating func initialisationJoueur(numeroJoueur : Int) -> JoueurStruct {
        if numeroJoueur == 1 {
            self.main.ajouterCarteCollection(carte : Carte(type : .Roi1, bool : true))
            for _ in 1...6 {
                self.pioche.ajouterCarteCollection(carte : Carte(type : TypedeCarte.Garde, bool : true))
            }
            for _ in 1...5 {
                self.pioche.ajouterCarteCollection(carte : Carte(type : TypedeCarte.Archer, bool : true))
            }
            for _ in 1...9 {
                self.pioche.ajouterCarteCollection(carte : Carte(type : TypedeCarte.Soldat, bool : true))
            }
        }
        else
        {
            self.main.ajouterCarteCollection(carte : Carte(type : TypedeCarte.Roi2, bool : false))
            for _ in 1...6 {
                self.pioche.ajouterCarteCollection(carte : Carte(type : TypedeCarte.Garde, bool : false))
            }
            for _ in 1...5 {
                self.pioche.ajouterCarteCollection(carte : Carte(type : TypedeCarte.Archer, bool : false))
            }
            for _ in 1...9 {
                self.pioche.ajouterCarteCollection(carte : Carte(type : TypedeCarte.Soldat, bool : false))
            }
        }
        self.pioche.cartes = self.pioche.cartes.shuffled()
        for _ in 1...3 {
            var carteaajoute : Carte?
            (self.pioche , carteaajoute) = self.pioche.getFirst()
            if let carte = carteaajoute {
                self.main.ajouterCarteCollection(carte : carte)
            }
        }
        return self
    }

    public func estRoiMort(autrejoueur : JoueurStruct) -> Bool {
    	for carte in self.cimetiere {
            if carte.getNomCarte() == "Roi1" || carte.getNomCarte() == "Roi2" {
                return true
            }
        }
        for carte in autrejoueur.royaume {
            if carte.getNomCarte() == "Roi1" || carte.getNomCarte() == "Roi2" {
                return true
            }
        }
        return false
    }

    public func estMainVide() -> Bool {
        return self.main.estvideCollection()
    }
}
