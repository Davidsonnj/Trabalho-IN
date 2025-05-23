from unidecode import unidecode
import pycountry
import pycountry_convert as pc


# Dicionário com nomes de países em português para inglês
mapa_ptbr_para_en = {
    "afeganistao": "Afghanistan",
    "africa do sul": "South Africa",
    "albania": "Albania",
    "alemanha": "Germany",
    "andorra": "Andorra",
    "angola": "Angola",
    "arabia saudita": "Saudi Arabia",
    "argelia": "Algeria",
    "argentina": "Argentina",
    "armenia": "Armenia",
    "australia": "Australia",
    "austria": "Austria",
    "azerbaijao": "Azerbaijan",
    "bahamas": "Bahamas",
    "bangladesh": "Bangladesh",
    "barbados": "Barbados",
    "barém": "Bahrain",
    "belgica": "Belgium",
    "belize": "Belize",
    "benin": "Benin",
    "bolivia": "Bolivia",
    "bosnia e herzegovina": "Bosnia and Herzegovina",
    "botswana": "Botswana",
    "brasil": "Brazil",
    "bulgaria": "Bulgaria",
    "burkina faso": "Burkina Faso",
    "butao": "Bhutan",
    "cabo verde": "Cape Verde",
    "camaroes": "Cameroon",
    "canada": "Canada",
    "catar": "Qatar",
    "chile": "Chile",
    "china": "China",
    "chipre": "Cyprus",
    "colombia": "Colombia",
    "coreia do norte": "North Korea",
    "coreia do sul": "South Korea",
    "costa rica": "Costa Rica",
    "croacia": "Croatia",
    "cuba": "Cuba",
    "dinamarca": "Denmark",
    "egito": "Egypt",
    "emirados arabes unidos": "United Arab Emirates",
    "equador": "Ecuador",
    "eslovaquia": "Slovakia",
    "eslovenia": "Slovenia",
    "espanha": "Spain",
    "estados unidos": "United States",
    "estonia": "Estonia",
    "etiopia": "Ethiopia",
    "filipinas": "Philippines",
    "finlandia": "Finland",
    "franca": "France",
    "grecia": "Greece",
    "guatemala": "Guatemala",
    "guine": "Guinea",
    "haiti": "Haiti",
    "holanda": "Netherlands",
    "honduras": "Honduras",
    "hungria": "Hungary",
    "india": "India",
    "indonesia": "Indonesia",
    "ira": "Iran",
    "iraque": "Iraq",
    "irlanda": "Ireland",
    "islandia": "Iceland",
    "israel": "Israel",
    "italia": "Italy",
    "jamaica": "Jamaica",
    "japao": "Japan",
    "jordania": "Jordan",
    "kosovo": "Kosovo",
    "kuwait": "Kuwait",
    "letonia": "Latvia",
    "libano": "Lebanon",
    "libia": "Libya",
    "liechtenstein": "Liechtenstein",
    "lituania": "Lithuania",
    "luxemburgo": "Luxembourg",
    "macedonia": "North Macedonia",
    "malasia": "Malaysia",
    "malawi": "Malawi",
    "malta": "Malta",
    "marrocos": "Morocco",
    "mexico": "Mexico",
    "mocambique": "Mozambique",
    "monaco": "Monaco",
    "mongolia": "Mongolia",
    "montenegro": "Montenegro",
    "namibia": "Namibia",
    "nepal": "Nepal",
    "nicaragua": "Nicaragua",
    "niger": "Niger",
    "nigeria": "Nigeria",
    "noruega": "Norway",
    "nova zelandia": "New Zealand",
    "oma": "Oman",
    "paquistao": "Pakistan",
    "paraguai": "Paraguay",
    "peru": "Peru",
    "polonia": "Poland",
    "portugal": "Portugal",
    "quenia": "Kenya",
    "reino unido": "United Kingdom",
    "republica checa": "Czech Republic",
    "republica dominicana": "Dominican Republic",
    "romenia": "Romania",
    "russia": "Russia",
    "salvador": "El Salvador",
    "senegal": "Senegal",
    "servia": "Serbia",
    "singapura": "Singapore",
    "siria": "Syria",
    "somalia": "Somalia",
    "suecia": "Sweden",
    "suica": "Switzerland",
    "tailandia": "Thailand",
    "taiwan": "Taiwan",
    "tanzania": "Tanzania",
    "tunisia": "Tunisia",
    "turquia": "Turkey",
    "ucrania": "Ukraine",
    "uruguai": "Uruguay",
    "venezuela": "Venezuela",
    "vietna": "Vietnam",
    "zambia": "Zambia",
    "zimbabue": "Zimbabwe"
}

def traduzir_pais_ptbr_para_en(nome_ptbr):
    nome_ptbr = unidecode(nome_ptbr.lower().strip())
    return mapa_ptbr_para_en.get(nome_ptbr, None)

def obter_continente(nome_pais_ptbr):
    pais_en = traduzir_pais_ptbr_para_en(nome_pais_ptbr)
    if not pais_en:
        return f"País '{nome_pais_ptbr}' não encontrado no dicionário."
    
    try:
        pais = pycountry.countries.get(name=pais_en)
        if not pais:
            # Às vezes, o pycountry pode ter nomes diferentes; tenta buscar pelo official_name
            pais = pycountry.countries.search_fuzzy(pais_en)[0]
        
        codigo_alpha2 = pais.alpha_2
        continente_codigo = pc.country_alpha2_to_continent_code(codigo_alpha2)
        
        continente_nome = {
            'AF': 'África',
            'NA': 'América do Norte',
            'OC': 'Oceania',
            'AN': 'Antártida',
            'AS': 'Ásia',
            'EU': 'Europa',
            'SA': 'América do Sul'
        }
        
        return continente_nome.get(continente_codigo, "Continente desconhecido")
    
    except Exception as e:
        return f"Erro ao buscar continente: {str(e)}"