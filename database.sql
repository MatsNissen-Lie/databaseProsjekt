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
    FOREIGN KEY (SesongId) REFERENCES Sesong(sesongId),
    FOREIGN KEY (TeaterstykkeNavn) REFERENCES Theaterstykke(Navn),
    FOREIGN KEY (SalNavn) REFERENCES Teatersal(Navn)
);
CREATE TABLE Ansatt (
    ansattId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    epost VARCHAR(255),
    navn VARCHAR(255),
    ansattstatus VARCHAR(255),
    arbeidstittel VARCHAR(255)
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
    Område VARCHAR(255) CHECK(
        Område IN (
            ' Hovedområde ',
            ' Galleri ',
            ' Parkett ',
            ' Balkong '
        )
    ),
    SalNavn VARCHAR(255) NOT NULL,
    PRIMARY KEY (RadNr, StolNr, Område, SalNavn),
    FOREIGN KEY (SalNavn) REFERENCES Teatersal(Navn)
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
    FOREIGN KEY (BillettKjopNummer) REFERENCES Billettkjøp(Nummer),
    FOREIGN KEY (Billettype, TeaterstykkeNavn) REFERENCES BilletType(Billettype, TeaterstykkeNavn),
    FOREIGN KEY (RadNr, StolNr, Område, salNavn) REFERENCES Stol(RadNr, StolNr, Område, Navn),
    FOREIGN Key (ForestillingId) REFERENCES Forestilling(id)
);
CREATE TABLE Billettkjøp (
    ForestillingId INTEGER NOT NULL,
    Nummer INT NOT NULL,
    dato DATE,
    tid TIME,
    PRIMARY KEY (Nummer, ForestillingId),
    FOREIGN KEY (ForestillingId) REFERENCES Forestilling(id)
);
CREATE TABLE Forestilling (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    teaterstykkeNavn VARCHAR(255) NOT NULL,
    dato DATE,
    tid TIME,
    FOREIGN KEY (teaterstykkeNavn) REFERENCES Theaterstykke(Navn)
);
CREATE TABLE BilletType (
    teaterstykkeNavn VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL,
    pris DECIMAL NOT NULL,
    minAntall INT NOT NULL,
    PRIMARY KEY (teaterstykkeNavn, type),
    FOREIGN KEY (teaterstykkeNavn) REFERENCES Theaterstykke(Navn)
);
CREATE TABLE Rolle (
    teaterstykkeNavn VARCHAR(255) NOT NULL,
    navn VARCHAR(255) NOT NULL,
    PRIMARY KEY (teaterstykkeNavn, navn),
    FOREIGN KEY (teaterstykkeNavn) REFERENCES Theaterstykke(Navn)
);
CREATE TABLE Akt (
    teaterstykkeNavn VARCHAR(255) NOT NULL,
    nummer INT NOT NULL,
    aktnavn VARCHAR(255) NOT NULL,
    PRIMARY KEY (teaterstykkeNavn, nummer),
    FOREIGN KEY (teaterstykkeNavn) REFERENCES Theaterstykke(Navn)
);
CREATE TABLE RollePaAkt (
    teaterstykkeNavn VARCHAR(255) NOT NULL,
    Actnummer INT NOT NULL,
    rolleNavn VARCHAR(255) NOT NULL,
    PRIMARY KEY (teaterstykkeNavn, Actnummer, rolleNavn),
    FOREIGN KEY (teaterstykkeNavn) REFERENCES Theaterstykke(Navn),
    FOREIGN KEY (rolleNavn) REFERENCES Rolle(navn)
);
CREATE TABLE Task (
    Beskrivelse TEXT NOT NULL,
    Identifikator INT NOT NULL,
    Navn VARCHAR(255) NOT NULL,
    PRIMARY KEY (Beskrivelse, Identifikator, Navn),
    FOREIGN KEY (Beskrivelse) REFERENCES Oppgave(Beskrivelse),
    FOREIGN KEY (Identifikator) REFERENCES Ansatt(ansattId),
    FOREIGN KEY (Navn) REFERENCES Theaterstykke(Navn)
);
CREATE TABLE Skuespiller (
    Identifikator INT NOT NULL,
    TeaterstykkeNavn VARCHAR(255) NOT NULL,
    RolleNavn VARCHAR(255) NOT NULL,
    PRIMARY KEY (Identifikator, TeaterstykkeNavn, RolleNavn),
    FOREIGN KEY (Identifikator) REFERENCES Ansatt(ansattId),
    FOREIGN KEY (TeaterstykkeNavn) REFERENCES Theaterstykke(Navn),
    FOREIGN KEY (RolleNavn) REFERENCES Rolle(navn)
);