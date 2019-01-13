import Foundation


public struct CarteStruct : CarteProtocol {

    internal var nomcarte : TypedeCarte
    internal var nbattaque : Int
    internal var nbdefense : Int
    internal var nbdefenseendefense :  Int
    internal var nbdefenseenattaque : Int
    internal var listeporte : [NomPosition]
    internal var nbdegat : Int
    internal var estpositiondef : Bool
    internal var appartientJ1 : Bool

    public init(type : TypedeCarte, bool : Bool) {
    	nbdegat = 0
    	nomcarte = type
        estpositiondef = true
        listeporte = []
        appartientJ1 = bool

    	switch type{
    	 case .Roi1:
    	 	nbattaque = 1
    	 	nbdefenseendefense = 4
    	 	nbdefenseenattaque = 4
    	 case .Roi2:
    	 	nbattaque = 1
    	 	nbdefenseendefense = 5
    	 	nbdefenseenattaque = 4
    	 case .Garde:
    	 	nbattaque = 1
    	 	nbdefenseendefense = 2
    	 	nbdefenseenattaque = 1
    	 case .Soldat:
    	 	nbattaque = 0
    	 	nbdefenseendefense = 2
    	 	nbdefenseenattaque = 1
    	 case .Archer:
    	 	nbattaque = 1
    	 	nbdefenseendefense = 2
    	 	nbdefenseenattaque = 1

            
    	 }
        nbdefense = nbdefenseenattaque 
    }

    public func getNomCarte() -> String {
		switch self.nomcarte {
            case .Roi1 :
                return "Roi1"
            case .Roi2 :
                return "Roi2"
            case .Garde :
                return "Garde"
            case .Soldat :
                return "Soldat"
            case .Archer :
                return "Archer"
         
        }
    }

    
    public func getValDef() -> Int {
    	return self.nbdefense
    	}
    

    public func getValAtq() -> Int {
    	return self.nbattaque
    } 

    public func getEstPositionDef() -> Bool {
    	return !self.estpositiondef
    }

    public func getPortee () -> String?{
        if self.listeporte.count == 0{
            return nil
	    }
        else{
            var stringportee = ""
            
            for i in self.listeporte{
                    switch i {
                case .F1 :
                    stringportee += "F1"
                case .F2 :
                    stringportee += "F2"
                case .F3 :
                    stringportee += "F3"
                case .A1 :
                    stringportee += "A1"
                case .A2 :
                    stringportee += "A2"
                case .A3 :
                    stringportee += "A3"
                }
            }
            return stringportee
            }
        }
    

    public mutating func mettrepositionOff() -> CarteStruct{
        self.estpositiondef = true
        self.nbdefense = self.nbdefenseenattaque
        return self
        }

    public mutating func mettrepositionDef() -> CarteStruct{
        self.estpositiondef = false
        self.nbdefense = self.nbdefenseendefense
        return self
    }
    public mutating func subirDegats(nombreDegats : Int) throws -> CarteStruct{
        self.nbdefense -= nombreDegats
        self.nbdegat += nombreDegats
        return self
    }

    public func nombreDegats() -> Int{
        return self.getValAtq()
    }
	
    public func getnbdegats() ->Int{
	    return self.nbdegat
    }

    public func getJoueur() -> Bool {
        return true //mdrr on oublie pas la moitie des fonctions noooooouuuuus
    }

    public mutating func setnbdegats(val : Int) -> CarteStruct{
        self.nbdegat += val
        return self
    }
    
    public mutating func reinitCarte()-> CarteStruct{
        if self.getEstPositionDef(){
            self.nbdefense = self.nbdefenseendefense
        }
        else {
            self.nbdefense = self.nbdefenseenattaque
        }
        self.nbdegat = 0
        return self
    }

    public mutating func changeValAtq (val: Int) throws -> CarteStruct{
        self.nbattaque += val
        return self
    }

    public func getnbdefenseendefense() -> Int{
        return self.nbdefenseendefense
    }
    
    public func getnbdefenseenattaque() -> Int{
        return self.nbdefenseenattaque
    }

    public func getAppartientJ1() -> Bool {
        return self.appartientJ1
    }

    public mutating func setAppartientJ1(boolJ1 : Bool) -> CarteStruct {
        self.appartientJ1 = boolJ1
        return self
    }
}

    
    
