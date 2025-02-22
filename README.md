# Climate Data Central

This repository aims to centralize and preserve critical climate data resources, ensuring their accessibility for future research and analysis.

### Author
* Elisa D'Amico
* Postdoctoral fellow, University of St Andrews
* ed248@st-andrews.ac.uk - Please email for data queries or additions. 

## Data Availability Status

**DATA NO LONGER AVAILABLE & CANNOT ACCESS:**

* The National Risk Index (NRI) - [NRI](https://hazards.fema.gov/nri/)
* USDA Climate Adaptation Data - [USDA](https://www.usda.gov/topics/climate-solutions)
* Geospatial Energy Mapper (GEM) - [GEM](https://gem.anl.gov/)
* Environmental Justice Screening and Mapping Tool - [EJ Tool](https://envirodatagov.org/epa-removes-ejscreen-from-its-website/)

**CAN ACCESS AT ALTERNATIVE SOURCES:**

* HUD Resilient Communities Data (HUD) - accessed on Humanitarian Data Exchange

## Repository Structure

* `data/`: Contains climate and resilience data files.
    * `climate/`: Climate-related data.
        * `temperature/`: Temperature-related data.
        * `water/`: Water-related data.
        * `other/`: Other climate-related data.
    * `resilience/`: Resilience-related data.
* `scripts/`: Contains R scripts and R Markdown documents.
* `README.md`: Project overview and instructions.

## Data Included

The repository includes the following datasets, categorized by type:

### Climate Data

#### Other
- **Air Data**: Air Quality Data Collected at Outdoor Monitors Across the US from 1980-Present. **File Format**: ZIP. [EPA Air Quality Monitoring](https://www.epa.gov/air-quality-data)
- **NCA Atlas Figures**: Figures related to the National Climate Assessment (NCA) for counties. [NCA Atlas](https://nca2018.globalchange.gov/)
- **NOAA Storm Events Database**: Contains data on storm events recorded by NOAA from 1950-Present. **File Format**: ZIP. [NOAA Storm Events](https://www.ncdc.noaa.gov/stormevents/)
- **NOAA Climate Data**: Various climate variables gathered from NOAA sources from 2000-Present. **File Format**: ZIP. [NOAA Climate Data Online](https://www.ncdc.noaa.gov/cdo-web/)

#### Water
- **Coastal Protection and Restoration Authority (CPRA)**: Data related to coastal protection and restoration efforts from 2019-2024. **File Format**: ZIP. [CPRA Data Portal](https://data.cpra.org/)
- **SST - Global, Yearly Difference from Average**: Yearly differences from average sea surface temperature from 2000-Present. **File Format**: ZIP. [NOAA SST Data](https://www.ncdc.noaa.gov/sst/)

#### Temperature
- **Mean Temperature (1991-2020)**: Monthly average temperature data. **File Format**: ZIP. [NOAA Climate Data Online](https://www.ncdc.noaa.gov/cdo-web/)
- **Ocean Yearly Heat Difference**: Yearly differences from average ocean heat content from 1901-Present. **File Format**: ZIP. [NOAA Ocean Data](https://www.ncei.noaa.gov/access/ocean/)

### Resilience Data
- **Resilience and Adaptation in New England (RAINE) Database**: Contains resilience-related data useful for understanding climate adaptation efforts in New England 2000-present. **File Format**: XLSX. [RAINE Database Resource]([https://www.raine.org/](https://www.epa.gov/raine))
- **Grantham Institute Climate Change Laws of the World**: Contains data related to climate change and local resilience efforts globally from 1947 - 2025. **File Format**: XLSX. [Grantham Research Institute](https://www.lse.ac.uk/GranthamInstitute/)

## How to Contribute

1. Fork this repository.
2. Create a new branch for your contributions.
3. Add your data or scripts to the appropriate folders.
4. Submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE) - see the `LICENSE` file for details.
