-- Generado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   en:        2023-03-31 11:50:40 CEST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE cita (
    fecha              DATE NOT NULL,
    hora               DATE NOT NULL,
    paciente_dni       VARCHAR2(45 CHAR) NOT NULL,
    consulta_numero    INTEGER NOT NULL,
    consulta_planta    INTEGER NOT NULL,
    p_sanit_p_sanit_id NUMBER NOT NULL
);

ALTER TABLE cita
    ADD CONSTRAINT cita_pk PRIMARY KEY ( fecha,
                                         hora,
                                         paciente_dni,
                                         consulta_numero,
                                         consulta_planta );

CREATE TABLE consulta (
    numero  INTEGER NOT NULL,
    planta  INTEGER NOT NULL,
    tamanio INTEGER NOT NULL,
    aforo   INTEGER NOT NULL
);

ALTER TABLE consulta ADD CONSTRAINT consulta_pk PRIMARY KEY ( numero,
                                                              planta );

CREATE TABLE efec_secun (
    descripcion          VARCHAR2(45 CHAR) NOT NULL,
    nivel_gravedad       INTEGER NOT NULL,
    frecuencia_aparicion INTEGER NOT NULL,
    medic_c_nacional     VARCHAR2(45 CHAR) NOT NULL
);

ALTER TABLE efec_secun
    ADD CONSTRAINT efec_secun_pk PRIMARY KEY ( descripcion,
                                               nivel_gravedad,
                                               frecuencia_aparicion,
                                               medic_c_nacional );

CREATE TABLE enf_medic (
    enfdad_cie10     VARCHAR2(45 CHAR) NOT NULL,
    medic_c_nacional VARCHAR2(45 CHAR) NOT NULL
);

ALTER TABLE enf_medic ADD CONSTRAINT enf_medic_pk PRIMARY KEY ( enfdad_cie10,
                                                                medic_c_nacional );

CREATE TABLE enfdad (
    cie10           VARCHAR2(45 CHAR) NOT NULL,
    cronica         CHAR(1) NOT NULL,
    nombre          VARCHAR2(45 CHAR) NOT NULL,
    tasa_mortalidad INTEGER NOT NULL,
    tasa_letalidad  INTEGER NOT NULL
);

ALTER TABLE enfdad ADD CONSTRAINT enfdad_pk PRIMARY KEY ( cie10 );

CREATE TABLE enfermero (
    p_sanit_p_sanit_id NUMBER NOT NULL,
    codigo             VARCHAR2(45 CHAR) NOT NULL,
    turno              VARCHAR2(45 CHAR) NOT NULL
);

ALTER TABLE enfermero ADD CONSTRAINT enfermero_pk PRIMARY KEY ( p_sanit_p_sanit_id );

ALTER TABLE enfermero ADD CONSTRAINT enfermero_codigo_un UNIQUE ( codigo );

CREATE TABLE fam_medic (
    familia_medicamento VARCHAR2(35 CHAR) NOT NULL,
    medic_c_nacional    VARCHAR2(45 CHAR) NOT NULL
);

ALTER TABLE fam_medic ADD CONSTRAINT fam_medic_pk PRIMARY KEY ( familia_medicamento,
                                                                medic_c_nacional );

CREATE TABLE farm_no_finan (
    farmacia_n_licencia INTEGER NOT NULL,
    no_finan_c_nacional VARCHAR2(45 CHAR) NOT NULL
);

ALTER TABLE farm_no_finan ADD CONSTRAINT farm_no_finan_pk PRIMARY KEY ( farmacia_n_licencia,
                                                                        no_finan_c_nacional );

CREATE TABLE farmacia (
    n_licencia INTEGER NOT NULL,
    ubicacion  VARCHAR2(45 CHAR) NOT NULL
);

ALTER TABLE farmacia ADD CONSTRAINT farmacia_pk PRIMARY KEY ( n_licencia );

CREATE TABLE finan (
    c_nacional VARCHAR2(45 CHAR) NOT NULL,
    pvp        FLOAT NOT NULL,
    pvl        FLOAT NOT NULL
);

ALTER TABLE finan ADD CONSTRAINT finan_pk PRIMARY KEY ( c_nacional );

CREATE TABLE historial_medico (
    n_registro   INTEGER NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_cierre DATE,
    paciente_dni VARCHAR2(45 CHAR) NOT NULL
);

CREATE UNIQUE INDEX historial_medico__idx ON
    historial_medico (
        paciente_dni
    ASC );

ALTER TABLE historial_medico ADD CONSTRAINT historial_medico_pk PRIMARY KEY ( n_registro );

CREATE TABLE medic (
    c_nacional         VARCHAR2(45 CHAR) NOT NULL,
    nombre             VARCHAR2(45 CHAR) NOT NULL,
    via_administracion VARCHAR2(45 CHAR) NOT NULL,
    presentacion       VARCHAR2(45 CHAR) NOT NULL,
    formato            VARCHAR2(45 CHAR) NOT NULL,
    receta             VARCHAR2(45 CHAR) NOT NULL,
    medic_type         VARCHAR2(8) NOT NULL
);

ALTER TABLE medic
    ADD CONSTRAINT ch_inh_medic CHECK ( medic_type IN ( 'FINAN', 'MEDIC', 'NO_FINAN' ) );

ALTER TABLE medic ADD CONSTRAINT medic_pk PRIMARY KEY ( c_nacional );

CREATE TABLE medico (
    p_sanit_p_sanit_id NUMBER NOT NULL,
    id_m               VARCHAR2(45 CHAR) NOT NULL,
    especializacion    VARCHAR2(45 CHAR) NOT NULL,
    anios_trabajo      INTEGER NOT NULL
);

ALTER TABLE medico ADD CONSTRAINT medico_pk PRIMARY KEY ( p_sanit_p_sanit_id );

ALTER TABLE medico ADD CONSTRAINT medico_id_m_un UNIQUE ( id_m );

CREATE TABLE no_finan (
    c_nacional VARCHAR2(45 CHAR) NOT NULL
);

ALTER TABLE no_finan ADD CONSTRAINT no_finan_pk PRIMARY KEY ( c_nacional );

CREATE TABLE p_sanit (
    p_sanit_id   NUMBER NOT NULL,
    p_sanit_type VARCHAR2(9) NOT NULL
);

ALTER TABLE p_sanit
    ADD CONSTRAINT ch_inh_p_sanit CHECK ( p_sanit_type IN ( 'ENFERMERO', 'MEDICO', 'P_SANIT' ) );

ALTER TABLE p_sanit ADD CONSTRAINT p_sanit_pk PRIMARY KEY ( p_sanit_id );

CREATE TABLE pac_enf (
    paciente_dni VARCHAR2(45 CHAR) NOT NULL,
    enfdad_cie10 VARCHAR2(45 CHAR) NOT NULL,
    duracion     VARCHAR2(56 CHAR) NOT NULL
);

ALTER TABLE pac_enf ADD CONSTRAINT pac_enf_pk PRIMARY KEY ( paciente_dni,
                                                            enfdad_cie10 );

CREATE TABLE paciente (
    dni                         VARCHAR2(45 CHAR) NOT NULL,
    nombre                      VARCHAR2(34 CHAR) NOT NULL,
    apellido                    VARCHAR2(45 CHAR) NOT NULL,
    fecha_nacimiento            DATE NOT NULL,
    historial_medico_n_registro INTEGER NOT NULL
);

CREATE UNIQUE INDEX paciente__idx ON
    paciente (
        historial_medico_n_registro
    ASC );

ALTER TABLE paciente ADD CONSTRAINT paciente_pk PRIMARY KEY ( dni );

CREATE TABLE sintomas (
    sintomas     VARCHAR2(45 CHAR) NOT NULL,
    enfdad_cie10 VARCHAR2(45 CHAR) NOT NULL
);

ALTER TABLE sintomas ADD CONSTRAINT sintomas_pk PRIMARY KEY ( sintomas,
                                                              enfdad_cie10 );

ALTER TABLE cita
    ADD CONSTRAINT cita_consulta_fk FOREIGN KEY ( consulta_numero,
                                                  consulta_planta )
        REFERENCES consulta ( numero,
                              planta );

ALTER TABLE cita
    ADD CONSTRAINT cita_p_sanit_fk FOREIGN KEY ( p_sanit_p_sanit_id )
        REFERENCES p_sanit ( p_sanit_id );

ALTER TABLE cita
    ADD CONSTRAINT cita_paciente_fk FOREIGN KEY ( paciente_dni )
        REFERENCES paciente ( dni );

ALTER TABLE efec_secun
    ADD CONSTRAINT efec_secun_medic_fk FOREIGN KEY ( medic_c_nacional )
        REFERENCES medic ( c_nacional );

ALTER TABLE enf_medic
    ADD CONSTRAINT enf_medic_enfdad_fk FOREIGN KEY ( enfdad_cie10 )
        REFERENCES enfdad ( cie10 );

ALTER TABLE enf_medic
    ADD CONSTRAINT enf_medic_medic_fk FOREIGN KEY ( medic_c_nacional )
        REFERENCES medic ( c_nacional );

ALTER TABLE enfermero
    ADD CONSTRAINT enfermero_p_sanit_fk FOREIGN KEY ( p_sanit_p_sanit_id )
        REFERENCES p_sanit ( p_sanit_id );

ALTER TABLE fam_medic
    ADD CONSTRAINT fam_medic_medic_fk FOREIGN KEY ( medic_c_nacional )
        REFERENCES medic ( c_nacional );

ALTER TABLE farm_no_finan
    ADD CONSTRAINT farm_no_finan_farmacia_fk FOREIGN KEY ( farmacia_n_licencia )
        REFERENCES farmacia ( n_licencia );

ALTER TABLE farm_no_finan
    ADD CONSTRAINT farm_no_finan_no_finan_fk FOREIGN KEY ( no_finan_c_nacional )
        REFERENCES no_finan ( c_nacional );

ALTER TABLE finan
    ADD CONSTRAINT finan_medic_fk FOREIGN KEY ( c_nacional )
        REFERENCES medic ( c_nacional );

ALTER TABLE historial_medico
    ADD CONSTRAINT historial_medico_paciente_fk FOREIGN KEY ( paciente_dni )
        REFERENCES paciente ( dni );

ALTER TABLE medico
    ADD CONSTRAINT medico_p_sanit_fk FOREIGN KEY ( p_sanit_p_sanit_id )
        REFERENCES p_sanit ( p_sanit_id );

ALTER TABLE no_finan
    ADD CONSTRAINT no_finan_medic_fk FOREIGN KEY ( c_nacional )
        REFERENCES medic ( c_nacional );

ALTER TABLE pac_enf
    ADD CONSTRAINT pac_enf_enfdad_fk FOREIGN KEY ( enfdad_cie10 )
        REFERENCES enfdad ( cie10 );

ALTER TABLE pac_enf
    ADD CONSTRAINT pac_enf_paciente_fk FOREIGN KEY ( paciente_dni )
        REFERENCES paciente ( dni );

ALTER TABLE paciente
    ADD CONSTRAINT paciente_historial_medico_fk FOREIGN KEY ( historial_medico_n_registro )
        REFERENCES historial_medico ( n_registro );

ALTER TABLE sintomas
    ADD CONSTRAINT sintomas_enfdad_fk FOREIGN KEY ( enfdad_cie10 )
        REFERENCES enfdad ( cie10 );

CREATE OR REPLACE TRIGGER arc_fkarc_1_no_finan BEFORE
    INSERT OR UPDATE OF c_nacional ON no_finan
    FOR EACH ROW
DECLARE
    d VARCHAR2(8);
BEGIN
    SELECT
        a.medic_type
    INTO d
    FROM
        medic a
    WHERE
        a.c_nacional = :new.c_nacional;

    IF ( d IS NULL OR d <> 'NO_FINAN' ) THEN
        raise_application_error(-20223, 'FK NO_FINAN_MEDIC_FK in Table NO_FINAN violates Arc constraint on Table MEDIC - discriminator column MEDIC_TYPE doesn''t have value ''NO_FINAN'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_1_finan BEFORE
    INSERT OR UPDATE OF c_nacional ON finan
    FOR EACH ROW
DECLARE
    d VARCHAR2(8);
BEGIN
    SELECT
        a.medic_type
    INTO d
    FROM
        medic a
    WHERE
        a.c_nacional = :new.c_nacional;

    IF ( d IS NULL OR d <> 'FINAN' ) THEN
        raise_application_error(-20223, 'FK FINAN_MEDIC_FK in Table FINAN violates Arc constraint on Table MEDIC - discriminator column MEDIC_TYPE doesn''t have value ''FINAN'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_2_enfermero BEFORE
    INSERT OR UPDATE OF p_sanit_p_sanit_id ON enfermero
    FOR EACH ROW
DECLARE
    d VARCHAR2(9);
BEGIN
    SELECT
        a.p_sanit_type
    INTO d
    FROM
        p_sanit a
    WHERE
        a.p_sanit_id = :new.p_sanit_p_sanit_id;

    IF ( d IS NULL OR d <> 'ENFERMERO' ) THEN
        raise_application_error(-20223, 'FK ENFERMERO_P_SANIT_FK in Table ENFERMERO violates Arc constraint on Table P_SANIT - discriminator column P_SANIT_TYPE doesn''t have value ''ENFERMERO'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_2_medico BEFORE
    INSERT OR UPDATE OF p_sanit_p_sanit_id ON medico
    FOR EACH ROW
DECLARE
    d VARCHAR2(9);
BEGIN
    SELECT
        a.p_sanit_type
    INTO d
    FROM
        p_sanit a
    WHERE
        a.p_sanit_id = :new.p_sanit_p_sanit_id;

    IF ( d IS NULL OR d <> 'MEDICO' ) THEN
        raise_application_error(-20223, 'FK MEDICO_P_SANIT_FK in Table MEDICO violates Arc constraint on Table P_SANIT - discriminator column P_SANIT_TYPE doesn''t have value ''MEDICO'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE SEQUENCE p_sanit_p_sanit_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER p_sanit_p_sanit_id_trg BEFORE
    INSERT ON p_sanit
    FOR EACH ROW
    WHEN ( new.p_sanit_id IS NULL )
BEGIN
    :new.p_sanit_id := p_sanit_p_sanit_id_seq.nextval;
END;
/



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            18
-- CREATE INDEX                             2
-- ALTER TABLE                             40
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           5
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          1
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0

