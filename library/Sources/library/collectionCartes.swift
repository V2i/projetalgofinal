import Foundation

public struct  CollectionDeCartesStruct : CollectiondeCarteProtocol {
	public typealias Carte = CarteStruct


    internal var cartes : [Carte]


	public init(){
		cartes = []
		
	}

    public func estvideCollection () -> Bool{
    	return self.cartes.count == 0
    }

    @discardableResult
    public mutating func ajouterCarteCollection (carte : Carte) -> CollectionDeCartesStruct {
    	self.cartes.append(carte)
    	return self
    }

    public mutating func supprimerCarteCollection(carte : Carte) -> (CollectionDeCartesStruct, Carte?){
    	let compt = self.cartes.count
        var cardremoved : Carte?
        cardremoved = nil
    	if !self.estvideCollection(){
    		var i = 0
    		var foundcarte = false
    		while !foundcarte && i<compt{
				if comparer(carte1 : cartes[i], carte2 : carte){
    				cardremoved = cartes[i]
    				self.cartes.remove(at : i)
    				foundcarte = true
    			}
    			i += 1
    		}
    		return (self, cardremoved)
    	}
    	else {
			
    		return (self, nil)
    	}
    }

    public mutating func sortirCarteCollection() -> (CollectionDeCartesStruct, Carte?) {
		var cardremoved : Carte
    	if !self.estvideCollection(){
    		cardremoved = self.cartes[self.cartes.count - 1]
    		self.cartes.remove(at : self.cartes.count - 1)
    		return (self, cardremoved)
    	}
    	else {
    		return (self, nil)
    	}
    }

    public func nombreCarteCollection () -> Int{
    	return self.cartes.count
    }

    public func makeIterator() -> ItCollection{
    	return ItCollection(main : self)
    }

    public mutating func getFirst() -> (CollectionDeCartesStruct, Carte?){
		var cardremoved : Carte
    	if !self.estvideCollection(){
    		cardremoved = self.cartes[0]
    		self.cartes.remove(at : 0)
    		return (self, cardremoved)
    	}
    	else{
			
    		return (self, nil)
    	}
    }

	public func comparer(carte1 : Carte, carte2 : Carte) -> Bool{
		return carte1.nbattaque == carte2.nbattaque && carte1.nbdefenseendefense == carte2.nbdefenseendefense && carte1.nbdefenseenattaque == carte2.nbdefenseenattaque && carte1.nbdegat == carte2.nbdegat && carte1.estpositiondef == carte2.estpositiondef && carte1.appartientJ1 == carte2.appartientJ1

	}

}

public struct ItCollection : IteratorProtocol {

	fileprivate var indexCourant : Int = 0
	fileprivate var carteC : CarteStruct? = nil
	fileprivate var main : [CarteStruct]

	init(main : CollectionDeCartesStruct) {
		self.main = main.cartes
        if self.main.count != 0 {
            carteC = self.main[indexCourant]
        }
	}

	public mutating func next() -> CarteStruct? {
        let tmp = carteC
        indexCourant+=1
        if indexCourant > 6 || self.main.count == 0 {
            carteC = nil
        }
        else {
            carteC = self.main[indexCourant]

        }
        return tmp
    }
}
