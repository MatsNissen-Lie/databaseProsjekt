CREATE TABLE Teatersal (
    Navn VARCHAR(255) PRIMARY KEY NOT NULL,
    Kapasitet INT
);
CREATE TABLE Theaterstykke (Navn VARCHAR(255) PRIMARY KEY NOT NULL);
CREATE TABLE Oppgave (Beskrivelse TEXT PRIMARY KEY NOT NULL);
CREATE TABLE Oppstilling (
    SesongId INTEGER NOT NULL,
    TeaterStykkeNavn VARCHAR(255) NOT NULL,
    SalNavn VARCHAR(255) NOT NULL,
    PRIMARY KEY (SesongId, TeaterStykkeNavn, SalNavn),
    FOREIGN KEY (SesongId) REFERENCES Sesong(SesongId) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (TeaterStykkeNavn) REFERENCES Theaterstykke(Navn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (SalNavn) REFERENCES Teatersal(Navn) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Ansatt (
    AnsattId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    Epost VARCHAR(255),
    Navn VARCHAR(255),
    Ansattstatus VARCHAR(255),
    ErSjef BOOLEAN DEFAULT FALSE
);
CREATE TABLE Kundeprofil (
    Mobilnummer VARCHAR(20) PRIMARY KEY NOT NULL,
    Navn VARCHAR(255),
    Adresse TEXT
);
CREATE TABLE Sesong (
    SesongId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    Navn VARCHAR(255),
    Startdato DATE,
    Sluttdato DATE
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
    SalNavn VARCHAR(255) NOT NULL,
    ForestillingNummer INTEGER NOT NULL,
    BillettKjøpNummer INT NOT NULL,
    Billettype VARCHAR(255) NOT NULL,
    TeaterStykkeNavn VARCHAR(255) NOT NULL,
    PRIMARY KEY (
        RadNr,
        StolNr,
        Område,
        SalNavn,
        ForestillingNummer
    ),
    FOREIGN KEY (BillettKjøpNummer) REFERENCES Billettkjøp(Nummer) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Billettype, TeaterStykkeNavn) REFERENCES BilletType(Billettype, TeaterStykkeNavn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (RadNr, StolNr, Område, SalNavn) REFERENCES Stol(RadNr, StolNr, Område, Navn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN Key (ForestillingNummer) REFERENCES Forestilling(Nummer) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Billettkjøp (
    TeaterStykkeNavn VARCHAR(255) NOT NULL,
    ForestillingNummer INTEGER NOT NULL,
    Nummer INTEGER NOT NULL,
    Mobilnummer VARCHAR(20) NOT NULL,
    Dato DATE,
    Tid TIME,
    PRIMARY KEY (Nummer, ForestillingNummer, TeaterStykkeNavn),
    FOREIGN KEY (ForestillingNummer) REFERENCES Forestilling(Nummer) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Mobilnummer) REFERENCES Kundeprofil(Mobilnummer) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (TeaterStykkeNavn) REFERENCES Theaterstykke(Navn) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Forestilling (
    TeaterStykkeNavn VARCHAR(255) NOT NULL,
    Nummer INTEGER NOT NULL,
    Dato DATE,
    Tid TIME,
    PRIMARY KEY (Nummer, TeaterStykkeNavn),
    FOREIGN KEY (TeaterStykkeNavn) REFERENCES Theaterstykke(Navn) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE BilletType (
    TeaterStykkeNavn VARCHAR(255) NOT NULL,
    Type VARCHAR(255) NOT NULL,
    Pris DECIMAL NOT NULL,
    MinAntall INT NOT NULL,
    PRIMARY KEY (TeaterStykkeNavn, Type),
    FOREIGN KEY (TeaterStykkeNavn) REFERENCES Theaterstykke(Navn) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Rolle (
    TeaterStykkeNavn VARCHAR(255) NOT NULL,
    Navn VARCHAR(255) NOT NULL,
    PRIMARY KEY (TeaterStykkeNavn, Navn),
    FOREIGN KEY (TeaterStykkeNavn) REFERENCES Theaterstykke(Navn) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Akt (
    TeaterStykkeNavn VARCHAR(255) NOT NULL,
    Nummer INTEGER NOT NULL,
    Aktnavn VARCHAR(255) NOT NULL,
    PRIMARY KEY (TeaterStykkeNavn, Nummer),
    FOREIGN KEY (TeaterStykkeNavn) REFERENCES Theaterstykke(Navn) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE RollePaAkt (
    TeaterStykkeNavn VARCHAR(255) NOT NULL,
    Actnummer INT NOT NULL,
    RolleNavn VARCHAR(255) NOT NULL,
    PRIMARY KEY (TeaterStykkeNavn, Actnummer, RolleNavn),
    FOREIGN KEY (TeaterStykkeNavn) REFERENCES Theaterstykke(Navn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (RolleNavn) REFERENCES Rolle(Navn) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Task (
    Beskrivelse TEXT NOT NULL,
    Identifikator INT NOT NULL,
    Navn VARCHAR(255) NOT NULL,
    PRIMARY KEY (Beskrivelse, Identifikator, Navn),
    FOREIGN KEY (Beskrivelse) REFERENCES Oppgave(Beskrivelse) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Identifikator) REFERENCES Ansatt(AnsattId) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Navn) REFERENCES Theaterstykke(Navn) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Skuespiller (
    Identifikator INT NOT NULL,
    TeaterStykkeNavn VARCHAR(255) NOT NULL,
    RolleNavn VARCHAR(255) NOT NULL,
    PRIMARY KEY (Identifikator, TeaterStykkeNavn, RolleNavn),
    FOREIGN KEY (Identifikator) REFERENCES Ansatt(AnsattId) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (TeaterStykkeNavn) REFERENCES Theaterstykke(Navn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (RolleNavn) REFERENCES Rolle(Navn) ON DELETE CASCADE ON UPDATE CASCADE
);