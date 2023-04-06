import random
import csv
import pandas as pd

# Función para generar nombres aleatorios
def generar_nombre():
    nombres = ['Juan', 'María', 'Pedro', 'Luisa', 'Ana', 'Carlos', 'Sofía', 'Diego', 'Lucía', 'Gabriel', 'Marta', 'Javier', 'Carmen', 
               'José', 'Andrea', 'Elena', 'Pablo', 'Isabel', 'Jorge', 'Laura', 'Antonio', 'Julia', 'Manuel', 'Valeria', 'Gonzalo', 'Clara', 
               'Adrián', 'Raquel', 'Francisco', 'Silvia', 'Roberto', 'Natalia', 'Emilio', 'Lorena', 'Fernando', 'Ángela', 'Mateo', 'Olga', 
               'Hugo', 'Patricia', 'Alberto', 'Carla', 'Santiago', 'Mónica', 'Guillermo', 'Rocío', 'Bruno', 'Alejandra', 'Ignacio', 'Lara', 
               'David', 'Cristina', 'Álvaro', 'Teresa', 'Josué', 'Beatriz', 'Rafael', 'Victoria', 'Enrique', 'Gloria', 'Daniel', 'Alicia', 
               'Oscar', 'Nuria', 'Mario', 'Paula', 'Marcos', 'Inés', 'Rubén', 'Mireia', 'Jesús', 'Esther', 'Albert', 'Alba', 'Miguel', 'Aurora', 
               'Alex', 'Belen', 'Jaime', 'Eva', 'Víctor', 'Elisa', 'Iván', 'Celia', 'Joaquín', 'Nerea', 'Lorenzo', 'Marina', 'Luis', 'Susana', 
               'Mariano', 'Ángeles', 'Xavier', 'Rosa', 'Alejandro', 'Rocio', 'Óscar', 'Noelia', 'Samuel', 'Marta', 'Sara', 'Sergio', 'Julio', 'Nacho', 
               'Nico', 'Judit', 'Vanesa', 'Eric', 'Lidia', 'Eduardo', 'Lucas', 'Carlos', 'Gabriela', 'Ainhoa', 'Josu', 'Mikel', 'Iker', 'Ion', 
               'Leire', 'Unai', 'Aritz', 'Ander', 'Maite', 'Irene', 'Ane', 'Oihana', 'Leonor', 'Alain', 'Markel', 'Jone', 'Irati', 'Gorka', 'Aitor', 
               'Aintzane', 'Amaia', 'Eneko', 'Iratxe', 'Nekane', 'Ibon', 'Aitor', 'Aitor', 'Amagoia', 'Ander', 'Ane', 'Anton', 'Aritz', 'Eider', 'Endika', 
               'Garikoitz', 'Gotzon', 'Hodei', 'Igor', 'Iraia', 'Iratxe', 'Itsaso', 'Izaskun', 'Jagoba', 'Josune', 'Julen', 'Lander', 'Leire', 'Lorea', 
               'Maialen', 'Maitane', 'Markel', 'Mikel', 'Naiara', 'Naroa', 'Nerea', 'Nestor', 'Nora', 'Oihana', 'Olatz', 'Oscar', 'Pello']
    return "'"+random.choice(nombres)+"'"

# Función para generar edades aleatorias entre 18 y 65 años
def generar_numero(a, b):
    return random.randint(a, b)

## Funcion generar boolean
def generar_boolean():
    return random.randint(0, 1)

#Funcion generar fechas
def generar_fechas():
    mes = generar_numero(1, 12)
    dia = generar_numero(1, 30)
    if (mes<10):
        mes = '0' + str(mes)
    if (dia<10):
        dia = '0' + str(dia)
    fecha = "'" + str(random.randint(1960, 2023)) + '/' + str(mes) + '/' + str(dia) + ' ' + generar_time(0) + "'"
    return convertir_fecha_oracle(fecha)

#Formato fecha oracle
def convertir_fecha_oracle(fecha):
    return "TO_DATE(" + fecha + ", 'YYYY/MM/DD HH24:MI:SS')"


#Funcion generar time con comillas simples
def generar_time(iden):
    hora = generar_numero(0, 23)
    if hora < 10:
        hora = "0" + str(hora)
    minuto = generar_numero(0, 59)
    if minuto < 10:
        minuto = "0" + str(minuto)
    segundo = generar_numero(0, 59)
    if segundo < 10:
        segundo = "0" + str(segundo)
    if iden == 1:
        time = "'" + str(hora) + ':' + str(minuto) + ':' + str(segundo) + "'"
        return "TO_TIMESTAMP(" + time + ", 'HH24:MI:SS')"
    else:
        return str(hora) + ':' + str(minuto) + ':' + str(segundo)


#Funcion enfermedad aleatoria
def obtener_enfermedad():
    enfermedades = ['GRIP', 'NEUM', 'BRON', 'MAL', 'SAR', 'VAR', 'TBC', 'VIH', 'CAC', 'FQ', 'ASMA', 'ART', 'EA', 'PKS', 
                    'EPL', 'ESQ', 'DEP', 'TA', 'TAAL', 'DM', 'HTA', 'ECC', 'ACV', 'EPOC', 'ECR', 'CU', 'ENDO', 'SII', 
                    'HB', 'HC', 'ERC', 'EM', 'FM', 'LES', 'PSO', 'ELY', 'MEN', 'ENC', 'FNO', 'FVR', 'ECH', 'LEP', 'ELE',
                    'DEN', 'ZIK', 'EBO']

    return "'"+random.choice(enfermedades)+"'"

#Funcion medicamento aleatorio
def obtener_medicamento():
    medicamentos = ['PCM', 'IBP', 'ASA', 'OME', 'AMX', 'LOR', 'DIA', 'ATV', 'RSV', 'MET', 'INS', 'HCTZ', 'LOS', 'ENA', 
                    'VAL', 'METO', 'AML', 'FUR', 'CLO', 'WAR', 'RIV', 'API', 'MFD', 'ALP', 'SET', 'ESC', 'VEN', 'TRA', 
                    'MOR', 'COD', 'HID', 'OXI', 'PGB', 'GAB', 'CAR', 'LAM', 'LEV', 'FEN', 'FBR', 'LVT', 'LTR', 'EST', 
                    'PRO', 'TST', 'FIN', 'TAD', 'SIL', 'RAN', 'CIP', 'AZI', 'CLI', 'DOX', 'FLU', 'KET', 'ERM', 'GEN', 
                    'VAN', 'MER', 'IMI', 'CEF', 'CTR', 'CFT', 'AMP', 'AMK', 'TOB']
    return "'"+random.choice(medicamentos)+"'"

#Funcion via administrativa
def obtener_via_administracion():
    vias_administracion = ['Oral', 'Sublingual', 'Intrav', 'Intram', 'Subcutánea', 'Transd', 'Inha', 'Rectal']
    return "'" + random.choice(vias_administracion) + "'"

#Funcion presentacion
def obtener_presentacion():
    presentaciones = ['Cápsulas', 'Comp', 'Píldoras', 'Líquido', 'Susp', 'Jarabe', 'Crema', 'Pomada']
    return "'" + random.choice(presentaciones)+"'"
#Receta
def obtener_receta():
    recetas = ['1 comp', '2 cáp', '5 ml', '1 cucharada', '1 gramo', '1 parche']
    return "'"+random.choice(recetas)+"'"
#Tipo
def obtener_tipo_medicamento():
    tipos = ['Analgesico', 'Antibiotico', 'Antiinflam', 'Antihistam', 'Antidep', 'Anticoag']
    return "'"+random.choice(tipos)+"'"

#Descripcion efectos secundarios
def obtener_efecto_secundario():
    efectos = ['Mareo', 'Náuseas', 'Vómitos', 'Dolor de cabeza', 'Somnolencia', 'Dolor de estómago']
    return "'"+random.choice(efectos)+"'"

#Sintomas
def obtener_sintoma():
    sintomas = ['Dolor de cabeza', 'Fiebre', 'Tos', 'Náuseas', 'Vómitos', 'Dolor de estómago']
    return "'"+random.choice(sintomas)+"'"

#ubicacion
def obtener_ciudad():
    ciudades = ['Madrid', 'Barcelona', 'Valencia', 'Sevilla', 'Zaragoza', 'Málaga', 'Murcia', 'Palma', 'Las Palmas', 'Bilbao']
    return "'"+random.choice(ciudades)+"'"

###### Comprobación de claves primarias

def check_csv_column(file_name, column_name, new_value):
    with open(file_name, 'r') as csv_file:
        reader = csv.DictReader(csv_file)
        return any(row[column_name] == new_value for row in reader)
###### Generación del archivo csv, y luego conversión al formato txt con una sintaxis

# Creación del archivo CSV y escritura de los encabezados de las columnas
with open('datos.csv', 'w', encoding='ISO-8859-1', newline='') as file:
    headers = ['P_SANIT_ID', 'P_SANIT_TYPE', 
              'P_SANIT_P_SANIT_ID', 'id_m', 'especializacion', 'anios_trabajo', 
              'codigo', 'turno',
              'fecha', 'hora', 'PACIENTE_dni', 'CONSULTA_numero', 'CONSULTA_planta', 
              'numero', 'planta', 'tamanio', 'aforo', 
              'dni', 'nombre_pac', 'apellido', 'fecha_nacimiento', 'HISTORIAL_MEDICO_n_registro',
              'n_registro', 'fecha_inicio', 'fecha_cierre', 
              'ENFDAD_cie10', 'duracion',
              'cie10', 'cronica', 'nombre_enfdad', 'tasa_mortalidad', 'tasa_letalidad',
              'MEDIC_c_nacional', 
              'c_nacional', 'nombre', 'via_administracion', 'presentacion', 'formato', 'receta', 'MEDIC_TYPE',
              'descripcion', 'nivel_gravedad', 'frecuencia_aparicion',
              'sintomas', 
              'familia_medicamento',
              'pvp', 'pvl', 'n_licencia', 'ubicacion', 'FARMACIA_n_licencia', 
              'NO_FINAN_c_nacional']
    writer = csv.writer(file)
    writer.writerow(headers)
    for i in range(1, 2):
        P_SANIT_ID = generar_numero(0, 10000)
        if (check_csv_column('datos.csv', 'P_SANIT_ID', P_SANIT_ID)):
            P_SANIT_ID = generar_numero(0, 100)
        SANIT_TYPE = ['MEDICO', 'ENFERMERO']
        P_SANIT_TYPE = "'" + SANIT_TYPE[generar_numero(0, 1)] + "'"
        
        P_SANIT_P_SANIT_ID = P_SANIT_ID
        id_m = generar_numero(0, 100)
        especializacion = generar_numero(0, 100)
        anios_trabajo = generar_numero(1, 30)
        
        codigo = generar_numero(0, 100)
        turno = generar_boolean()
        
        fecha = generar_fechas()
        hora = generar_time(1)
        PACIENTE_dni = generar_numero(0, 99999999)
        CONSULTA_numero = generar_numero(0, 100)
        CONSULTA_planta = generar_numero(0, 10)
        
        numero = CONSULTA_numero
        planta = CONSULTA_planta
        tamanio = generar_numero(0, 100)
        aforo = generar_numero(0, 10)
        
        dni = PACIENTE_dni
        if (check_csv_column('datos.csv', 'dni', dni)):
            PACIENTE_dni = generar_numero(0, 99999999)
            dni = PACIENTE_dni
        nombre_pac = generar_nombre()
        apellido = generar_nombre()
        fecha_nacimiento = generar_fechas()
        HISTORIAL_MEDICO_n_registro = generar_numero(0, 10000)
        
        n_registro = HISTORIAL_MEDICO_n_registro
        fecha_inicio = generar_fechas()
        fecha_cierre = generar_fechas()
        
        ENFDAD_cie10 = generar_numero(0, 10000)
        if (check_csv_column('datos.csv', 'ENFDAD_cie10', ENFDAD_cie10)):
            ENFDAD_cie10 = generar_numero(0, 10000)
        duracion = generar_numero(0, 1000)
        
        cie10 = ENFDAD_cie10
        cronica = generar_numero(0, 1)
        nombre_enfdad = obtener_enfermedad()
        tasa_mortalidad = generar_numero(0, 100)
        tasa_letalidad = generar_numero(0, 100)
        
        MEDIC_c_nacional = generar_numero(0, 10000)
        if (check_csv_column('datos.csv', 'MEDIC_c_nacional', MEDIC_c_nacional)):
            MEDIC_c_nacional = generar_numero(0, 10000)
        
        c_nacional = MEDIC_c_nacional
        nombre = obtener_medicamento()
        via_administracion = obtener_via_administracion()
        presentacion = obtener_presentacion()
        receta = obtener_receta()
        formato = presentacion
        MEDIC_TYPE = obtener_tipo_medicamento()
        
        descripcion = obtener_efecto_secundario()
        nivel_gravedad = generar_numero(0, 100)
        frecuencia_aparicion = generar_numero(0, 100)
        
        sintomas = obtener_sintoma()
        
        familia_medicamento = MEDIC_TYPE
        
        pvp = generar_numero(10, 1000)
        pvl = round((generar_numero(0, 100) / 100) * pvp)
        n_licencia = generar_numero(10000, 1000000)
        if (check_csv_column('datos.csv', 'n_licencia', n_licencia)):
            n_licencia = generar_numero(10000, 1000000)
        ubicacion = obtener_ciudad() 
        FARMACIA_n_licencia = n_licencia
        NO_FINAN_c_nacional = generar_numero(10000, 10000000)
        
        # Se declara por cada linea los datos generados aleatoriamente
        data = []
        data.append([P_SANIT_ID, P_SANIT_TYPE,
                      P_SANIT_P_SANIT_ID, id_m, especializacion, anios_trabajo,
                      codigo, turno,
                      fecha, hora, PACIENTE_dni, CONSULTA_numero, CONSULTA_planta,
                      numero, planta, tamanio, aforo,
                      dni, nombre_pac, apellido, fecha_nacimiento, HISTORIAL_MEDICO_n_registro,
                      n_registro, fecha_inicio, fecha_cierre,
                      ENFDAD_cie10, duracion,
                      cie10, cronica, nombre_enfdad, tasa_mortalidad, tasa_letalidad,
                      MEDIC_c_nacional,
                      c_nacional, nombre, via_administracion, presentacion, formato, receta, MEDIC_TYPE,
                      descripcion, nivel_gravedad, frecuencia_aparicion,
                      sintomas,
                      familia_medicamento, pvp, pvl, n_licencia, ubicacion,
                      FARMACIA_n_licencia, NO_FINAN_c_nacional])
        writer.writerows(data)

# Leer el archivo CSV
df = pd.read_csv("datos.csv", encoding="ISO-8859-1")

# Abrir un archivo de texto para escribir los datos
output_file = open("output.txt", "w")

# Escribir los encabezados y valores separados por ': '
for col in df.columns:
    output_file.write(col + ': ')
    values = [str(val) for val in df[col].values]
    output_file.write(', '.join(values) + '\n')

# Cerrar el archivo de texto
output_file.close()

# Funcion para generar las query's en SQL

def escribir_a_txt(encabezados_pedidos, texto):
    # Abrir el archivo CSV
    with open('datos.csv', 'r', newline='') as csvfile:
        reader = csv.DictReader(csvfile)

        # Abrir el archivo de texto para escribir los datos
        with open('prueba1.txt', 'a') as txtfile:  # Cambiar modo de 'w' a 'a'

            # Escribir cada fila
            for row in reader:
                valores = [row[encabezado] for encabezado in encabezados_pedidos]
                txtfile.write(f"INSERT INTO {texto}({', '.join(encabezados_pedidos)}) VALUES ")
                txtfile.write('(' + ', '.join(valores) + ');')
                txtfile.write('\n')

entidades_atributos = {}
entidades_atributos['HISTORIAL_MEDICO'] = ['n_registro', 'fecha_inicio', 'fecha_cierre', 'PACIENTE_dni']
entidades_atributos['PACIENTE'] = ['dni', 'nombre_pac', 'apellido', 'fecha_nacimiento', 'HISTORIAL_MEDICO_n_registro']
entidades_atributos['P_SANIT'] = ['P_SANIT_ID', 'P_SANIT_TYPE']
entidades_atributos['FARMACIA'] = ['n_licencia', 'ubicacion']
entidades_atributos['MEDIC'] = ['c_nacional', 'nombre', 'via_administracion', 'presentacion', 'formato', 'receta', 'MEDIC_TYPE']
entidades_atributos['FINAN'] = ['c_nacional', 'pvp', 'pvl']
entidades_atributos['NO_FINAN'] = ['c_nacional']
entidades_atributos['ENFDAD'] = ['cie10', 'cronica', 'nombre_enfdad', 'tasa_mortalidad', 'tasa_letalidad']

entidades_atributos['CITA'] = ['fecha', 'hora', 'PACIENTE_dni', 'CONSULTA_numero', 'CONSULTA_planta', 'P_SANIT_P_SANIT_ID']
entidades_atributos['CONSULTA'] = ['numero', 'planta', 'tamanio', 'aforo']
entidades_atributos['EFEC_SECUN'] = ['descripcion', 'nivel_gravedad', 'frecuencia_aparicion', 'MEDIC_c_nacional']
entidades_atributos['ENF_MEDIC'] = ['ENFDAD_cie10', 'MEDIC_c_nacional']
entidades_atributos['ENFERMERO'] = ['P_SANIT_P_SANIT_ID', 'codigo', 'turno']
entidades_atributos['FAM_MEDIC'] = ['familia_medicamento', 'MEDIC_c_nacional']
entidades_atributos['FARM_NO_FINAN'] = ['FARMACIA_n_licencia', 'NO_FINAN_c_nacional']
entidades_atributos['MEDICO'] = ['P_SANIT_P_SANIT_ID', 'id_m', 'especializacion', 'anios_trabajo']
entidades_atributos['PAC_ENF'] = ['PACIENTE_dni', 'ENFDAD_cie10', 'duracion']
entidades_atributos['FAM_MEDIC'] = ['familia_medicamento', 'MEDIC_c_nacional']
entidades_atributos['SINTOMAS'] = ['sintomas', 'ENFDAD_cie10']

#Ahora se va iterando con la función sobre el diccionario creado con las entidades y los campos
for texto, encabezados_pedidos in entidades_atributos.items():
    escribir_a_txt(encabezados_pedidos, texto)
