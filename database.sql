CREATE TABLE Teatersal (
    Navn VARCHAR(255) PRIMARY KEY NOT NULL,
    Kapasitet INT
);
CREATE TABLE Theaterstykke (Navn VARCHAR(255) PRIMARY KEY NOT NULL);
CREATE TABLE Oppgave (Beskrivelse TEXT PRIMARY KEY NOT NULL);
CREATE TABLE Oppstilling (
    SesongId INTEGER NOT NULL,
    TeaterstykkeNavn VARCHAR(255) NOT NULL,
    SalNavn VARCHAR(255) NOT NULL,
    PRIMARY KEY (SesongId, TeaterstykkeNavn, SalNavn),
    FOREIGN KEY (SesongId) REFERENCES Sesong(sesongId) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (TeaterstykkeNavn) REFERENCES Theaterstykke(Navn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (SalNavn) REFERENCES Teatersal(Navn) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Ansatt (
    ansattId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    epost VARCHAR(255),
    navn VARCHAR(255),
    ansattstatus VARCHAR(255),
    erSjef BOOLEAN DEFAULT FALSE
);
CREATE TABLE Kundeprofil (
    Mobilnummer VARCHAR(20) PRIMARY KEY NOT NULL,
    Navn VARCHAR(255),
    Adresse TEXT
);
CREATE TABLE Sesong (
    sesongId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    navn VARCHAR(255),
    startdato DATE,
    sluttdato DATE
);
CREATE TABLE Stol (
    RadNr INT,
    StolNr INT,
    Område VARCHAR(255) CHECK (
        Område IN (
            'Hovedområde',
            'Galleri',
            'Parkett',
            'Balkong'
        )
    ),
    SalNavn VARCHAR(255) NOT NULL,
    PRIMARY KEY (RadNr, StolNr, Område, SalNavn),
    FOREIGN KEY (SalNavn) REFERENCES Teatersal(Navn) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Billett (
    RadNr INT NOT NULL,
    StolNr INT NOT NULL,
    Område VARCHAR(255) NOT NULL,
    salNavn VARCHAR(255) NOT NULL,
    ForestillingId INTEGER NOT NULL,
    BillettKjopNummer INT NOT NULL,
    Billettype VARCHAR(255) NOT NULL,
    TeaterstykkeNavn VARCHAR(255) NOT NULL,
    PRIMARY KEY (RadNr, StolNr, Område, SalNavn, ForestillingId),
    FOREIGN KEY (BillettKjopNummer) REFERENCES Billettkjøp(Nummer) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Billettype, TeaterstykkeNavn) REFERENCES BilletType(Billettype, TeaterstykkeNavn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (RadNr, StolNr, Område, salNavn) REFERENCES Stol(RadNr, StolNr, Område, Navn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN Key (ForestillingId) REFERENCES Forestilling(id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Billettkjøp (
    ForestillingId INTEGER NOT NULL,
    Nummer INT NOT NULL,
    dato DATE,
    tid TIME,
    PRIMARY KEY (Nummer, ForestillingId),
    FOREIGN KEY (ForestillingId) REFERENCES Forestilling(id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Forestilling (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    teaterstykkeNavn VARCHAR(255) NOT NULL,
    dato DATE,
    tid TIME,
    FOREIGN KEY (teaterstykkeNavn) REFERENCES Theaterstykke(Navn) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE BilletType (
    teaterstykkeNavn VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL,
    pris DECIMAL NOT NULL,
    minAntall INT NOT NULL,
    PRIMARY KEY (teaterstykkeNavn, type),
    FOREIGN KEY (teaterstykkeNavn) REFERENCES Theaterstykke(Navn) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Rolle (
    teaterstykkeNavn VARCHAR(255) NOT NULL,
    navn VARCHAR(255) NOT NULL,
    PRIMARY KEY (teaterstykkeNavn, navn),
    FOREIGN KEY (teaterstykkeNavn) REFERENCES Theaterstykke(Navn) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Akt (
    teaterstykkeNavn VARCHAR(255) NOT NULL,
    nummer INT NOT NULL,
    aktnavn VARCHAR(255) NOT NULL,
    PRIMARY KEY (teaterstykkeNavn, nummer),
    FOREIGN KEY (teaterstykkeNavn) REFERENCES Theaterstykke(Navn) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE RollePaAkt (
    teaterstykkeNavn VARCHAR(255) NOT NULL,
    Actnummer INT NOT NULL,
    rolleNavn VARCHAR(255) NOT NULL,
    PRIMARY KEY (teaterstykkeNavn, Actnummer, rolleNavn),
    FOREIGN KEY (teaterstykkeNavn) REFERENCES Theaterstykke(Navn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (rolleNavn) REFERENCES Rolle(navn) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Task (
    Beskrivelse TEXT NOT NULL,
    Identifikator INT NOT NULL,
    Navn VARCHAR(255) NOT NULL,
    PRIMARY KEY (Beskrivelse, Identifikator, Navn),
    FOREIGN KEY (Beskrivelse) REFERENCES Oppgave(Beskrivelse) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Identifikator) REFERENCES Ansatt(ansattId) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Navn) REFERENCES Theaterstykke(Navn) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Skuespiller (
    Identifikator INT NOT NULL,
    TeaterstykkeNavn VARCHAR(255) NOT NULL,
    RolleNavn VARCHAR(255) NOT NULL,
    PRIMARY KEY (Identifikator, TeaterstykkeNavn, RolleNavn),
    FOREIGN KEY (Identifikator) REFERENCES Ansatt(ansattId) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (TeaterstykkeNavn) REFERENCES Theaterstykke(Navn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (RolleNavn) REFERENCES Rolle(navn) ON DELETE CASCADE ON UPDATE CASCADE
);