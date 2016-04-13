/*******************************************************************************
 * Copyright 2013 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 ******************************************************************************/
package emlab.gen.role.market;

import org.springframework.beans.factory.annotation.Autowired;

import agentspring.role.Role;
import agentspring.role.RoleComponent;
import emlab.gen.domain.agent.DecarbonizationModel;
import emlab.gen.repository.Reps;
import ilog.concert.IloException;
import ilog.concert.IloLinearNumExpr;
import ilog.concert.IloNumVar;
import ilog.cplex.IloCplex;

/**
 * @author asmkhan
 *
 */
@RoleComponent
public class ClearHourlyElectricityMarketRole extends AbstractClearElectricitySpotMarketRole<DecarbonizationModel>
implements Role<DecarbonizationModel> {

    @Autowired
    private Reps reps;

    // String inputFileDemandInZoneA = "/home/sk/Test CSVs/15 Time
    // Steps/Time_Series_Demand_A.csv";
    // String inputFileSolarIrradianceInZoneA = "/home/sk/Test CSVs/15 Time
    // Steps/Solar_Irradiance_A.csv";
    // String inputFileWindSpeedInZoneA = "/home/sk/Test CSVs/15 Time
    // Steps/Wind_Speed_A.csv";
    //
    // String inputFileElasticDemandInZoneA = "/home/sk/Test CSVs/8760 Time
    // Steps/Elastic_Time_Series_Demand_AA.csv";
    //
    // BufferedReader brDemandInZoneA = null;
    // BufferedReader brSolarIrradianceInZoneA = null;
    // BufferedReader brWindSpeedInZoneA = null;
    // BufferedReader brElasticDemandInZoneA = null;
    //
    // String line = "";
    //
    // ArrayList<String> DemandInZoneA = new ArrayList<String>();
    // ArrayList<String> SolarIrradianceInZoneA = new ArrayList<String>();
    // ArrayList<String> WindSpeedInZoneA = new ArrayList<String>();
    // ArrayList<String> ElasticDemandInZoneA = new ArrayList<String>();
    //
    // double[] totalDemand;
    // double[] SolarIrradiance;
    // double[] WindSpeed;
    // double[] ElasticDemandPerDay;

    ///////////////////////////////////////// parameters for country A

    double maxEnergycontentStorageA = 1000;
    double minEnergycontentStorageA = 0;
    double initialChargeInStorageA = 250;
    double maxStorageFlowInA = 1;
    double minStorageFlowInA = 0;
    double maxStorageFlowOutA = 1;
    double minStorageFlowOutA = 0;
    double nA = 0.90; // Storage efficiency
    double nInvA = 1 / nA; // Inverse efficiency

    double dailyMinConsumptionA = 0;
    double dailyMaxConsumptionA = Double.MAX_VALUE;

    //////////////////////////////////////////////////////////////////

    ///////////////////////////////////////// parameters for country B

    double maxEnergycontentStorageB = 1000;
    double minEnergycontentStorageB = 0;
    double initialChargeInStorageB = 500;
    double maxStorageFlowInB = 1;
    double minStorageFlowInB = 0;
    double maxStorageFlowOutB = 1;
    double minStorageFlowOutB = 0;
    double nB = 0.90; // Storage efficiency
    double nInvB = 1 / nB; // Inverse efficiency

    double dailyMinConsumptionB = 0;
    double dailyMaxConsumptionB = Double.MAX_VALUE;

    //////////////////////////////////////////////////////////////////

    ///////////////////////////////// parameters for Congestion Management

    double maxInterCapAandB = 3000;

    double minMarketCrossBorderFlowAandB = 0;
    double maxMarketCrossBorderFlowAandB = 3000;

    //////////////////////////////////////////////////////////////////

    // public void readInput() {
    // try {
    // brDemandInZoneA = new BufferedReader(new
    // FileReader(inputFileDemandInZoneA));
    // while ((line = brDemandInZoneA.readLine()) != null) {
    // DemandInZoneA.add(line);
    // }
    //
    // brSolarIrradianceInZoneA = new BufferedReader(new
    // FileReader(inputFileSolarIrradianceInZoneA));
    // while ((line = brSolarIrradianceInZoneA.readLine()) != null) {
    // SolarIrradianceInZoneA.add(line);
    // }
    //
    // brWindSpeedInZoneA = new BufferedReader(new
    // FileReader(inputFileWindSpeedInZoneA));
    // while ((line = brWindSpeedInZoneA.readLine()) != null) {
    // WindSpeedInZoneA.add(line);
    // }
    //
    // brElasticDemandInZoneA = new BufferedReader(new
    // FileReader(inputFileElasticDemandInZoneA));
    // while ((line = brElasticDemandInZoneA.readLine()) != null) {
    // ElasticDemandInZoneA.add(line);
    // }
    //
    // } catch (FileNotFoundException e) {
    // e.printStackTrace();
    // } catch (IOException e) {
    // e.printStackTrace();
    // } finally {
    // if (brDemandInZoneA != null) {
    // try {
    // brDemandInZoneA.close();
    // } catch (IOException e) {
    // e.printStackTrace();
    // }
    // }
    // if (brSolarIrradianceInZoneA != null) {
    // try {
    // brSolarIrradianceInZoneA.close();
    // } catch (IOException e) {
    // e.printStackTrace();
    // }
    // }
    // if (brWindSpeedInZoneA != null) {
    // try {
    // brWindSpeedInZoneA.close();
    // } catch (IOException e) {
    // e.printStackTrace();
    // }
    // }
    // if (brElasticDemandInZoneA != null) {
    // try {
    // brElasticDemandInZoneA.close();
    // } catch (IOException e) {
    // e.printStackTrace();
    // }
    // }
    // }
    // totalDemand = new double[DemandInZoneA.size()];
    // for (int i = 0; i < totalDemand.length; i++) {
    // totalDemand[i] = Double.parseDouble(DemandInZoneA.get(i));
    // }
    // SolarIrradiance = new double[SolarIrradianceInZoneA.size()];
    // for (int i = 0; i < SolarIrradiance.length; i++) {
    // SolarIrradiance[i] = Double.parseDouble(SolarIrradianceInZoneA.get(i));
    // }
    // WindSpeed = new double[WindSpeedInZoneA.size()];
    // for (int i = 0; i < WindSpeed.length; i++) {
    // WindSpeed[i] = Double.parseDouble(WindSpeedInZoneA.get(i));
    // }
    // ElasticDemandPerDay = new double[ElasticDemandInZoneA.size()];
    // for (int i = 0; i < ElasticDemandPerDay.length; i++) {
    // ElasticDemandPerDay[i] = Double.parseDouble(ElasticDemandInZoneA.get(i));
    // }
    // }

    @Override
    public void act(DecarbonizationModel model) {

        double marginalCostGasPlantA = 90.67;
        double marginalCostNuclearPlantA = 30.98;
        double marginalCostCoalPlantA = 50.44;
        double marginalCostWindPlantA = 0;
        double marginalCostSolarPlantA = 0;

        double maxGenerationCapacityGasPlantA = 4000;
        double maxGenerationCapacityNuclearPlantA = 2800;
        double maxGenerationCapacityCoalPlantA = 5000;
        double maxGenerationCapacityWindPlantA = 500;
        double maxGenerationCapacitySolarPlantA = 1000;

        double maxEnergycontentStorageA = 1000;
        double minEnergycontentStorageA = 0;
        double initialChargeInStorageA = 250;
        double maxStorageFlowInA = 1;
        double minStorageFlowInA = 0;
        double maxStorageFlowOutA = 1;
        double minStorageFlowOutA = 0;
        double nA = 0.90; // Storage efficiency
        double nInvA = 1 / nA; // Inverse efficiency

        double[] totalDemandA = new double[] { 10000, 5000, 10000, 5000, 10000, 10000, 5000, 10000, 5000, 10000, 10000, 5000, 10000, 5000, 10000 };

        double[] SolarIrradianceA = new double[] { 0.6, 0.7, 0.8, 0.9, 0.2, 0.6, 0.7, 0.8, 0.9, 0.2, 0.6, 0.7, 0.8, 0.9, 0.2 };
        double[] WindSpeedA = new double[] { 0.6, 0.7, 0.8, 0.9, 0.2, 0.6, 0.7, 0.8, 0.9, 0.2, 0.6, 0.7, 0.8, 0.9, 0.2 };

        double[] availableSolarCapacityA = new double[SolarIrradianceA.length];
        for (int i = 0; i < SolarIrradianceA.length; i++) {
            availableSolarCapacityA[i] = SolarIrradianceA[i] * maxGenerationCapacitySolarPlantA;
        }

        double[] availableWindCapacityA = new double[WindSpeedA.length];
        for (int i = 0; i < WindSpeedA.length; i++) {
            availableWindCapacityA[i] = WindSpeedA[i] * maxGenerationCapacityWindPlantA;
        }

        // Zone B

        double marginalCostGasPlantB = 90.67;
        double marginalCostNuclearPlantB = 30.98;
        double marginalCostCoalPlantB = 50.44;
        double marginalCostWindPlantB = 0;
        double marginalCostSolarPlantB = 0;

        double maxGenerationCapacityGasPlantB = 5000;
        double maxGenerationCapacityNuclearPlantB = 1800;
        double maxGenerationCapacityCoalPlantB = 3000;
        double maxGenerationCapacityWindPlantB = 600;
        double maxGenerationCapacitySolarPlantB = 900;

        double maxEnergycontentStorageB = 1000;
        double minEnergycontentStorageB = 0;
        double initialChargeInStorageB = 500;
        double maxStorageFlowInB = 1;
        double minStorageFlowInB = 0;
        double maxStorageFlowOutB = 1;
        double minStorageFlowOutB = 0;
        double nB = 0.90; // Storage efficiency
        double nInvB = 1 / nB; // Inverse efficiency

        double[] totalDemandB = new double[] { 2000, 10000, 2500, 10000, 5000, 10000, 5000, 10000, 5000, 10000, 5000, 10000,
                5000, 10000, 5000 };

        double[] SolarIrradianceB = new double[] { 0.6, 0.7, 0.8, 0.9, 0.2, 0.6, 0.7, 0.8, 0.9, 0.2, 0.6, 0.7, 0.8, 0.9,
                0.2 };
        double[] WindSpeedB = new double[] { 0.6, 0.7, 0.8, 0.9, 0.2, 0.6, 0.7, 0.8, 0.9, 0.2, 0.6, 0.7, 0.8, 0.9,
                0.2 };

        double[] availableSolarCapacityB = new double[SolarIrradianceB.length];
        for (int i = 0; i < SolarIrradianceB.length; i++) {
            availableSolarCapacityB[i] = SolarIrradianceB[i] * maxGenerationCapacitySolarPlantB;
        }

        double[] availableWindCapacityB = new double[WindSpeedB.length];
        for (int i = 0; i < WindSpeedB.length; i++) {
            availableWindCapacityB[i] = WindSpeedB[i] * maxGenerationCapacityWindPlantB;
        }

        // Market coupling (congestion management)

        double maxInterCapAandB = 3000;

        double minMarketCrossBorderFlowAandB = 0;
        double maxMarketCrossBorderFlowAandB = 3000;

        System.out.println("----------------------------------------------------------");
        System.out.println("Starting optimization model");

        int timeSteps = 15;

        try {
            IloCplex cplex1 = new IloCplex();

            // defining variables for Zone A //////////////////////////////////////////////////////////////////////////////////////

            IloNumVar[] generationCapacityGasPlantA = new IloNumVar[timeSteps];
            for (int i = 0; i < timeSteps; i++) {
                generationCapacityGasPlantA[i] = cplex1.numVar(0, maxGenerationCapacityGasPlantA);
            }

            IloNumVar[] generationCapacityNuclearPlantA = new IloNumVar[timeSteps];
            for (int i = 0; i < timeSteps; i++) {
                generationCapacityNuclearPlantA[i] = cplex1.numVar(0, maxGenerationCapacityNuclearPlantA);
            }

            IloNumVar[] generationCapacityCoalPlantA = new IloNumVar[timeSteps];
            for (int i = 0; i < timeSteps; i++) {
                generationCapacityCoalPlantA[i] = cplex1.numVar(0, maxGenerationCapacityCoalPlantA);
            }

            IloNumVar[] generationCapacityWindPlantA = new IloNumVar[timeSteps];
            for (int i = 0; i < timeSteps; i++) {
                generationCapacityWindPlantA[i] = cplex1.numVar(0, availableWindCapacityA[i]);
            }

            IloNumVar[] generationCapacitySolarPlantA = new IloNumVar[timeSteps];
            for (int i = 0; i < timeSteps; i++) {
                generationCapacitySolarPlantA[i] = cplex1.numVar(0, availableSolarCapacityA[i]);
            }

            IloNumVar[] demandPerHourA = new IloNumVar[timeSteps];
            for (int i = 0; i < timeSteps; i++) {
                demandPerHourA[i] = cplex1.numVar(totalDemandA[i], totalDemandA[i]);
            }

            IloNumVar[] storageChargingA = new IloNumVar[timeSteps];
            for (int i = 0; i < timeSteps; i++) {
                storageChargingA[i] = cplex1.numVar(minStorageFlowInA, maxStorageFlowInA);
            }

            IloNumVar[] storageDischargingA = new IloNumVar[timeSteps];
            for (int i = 0; i < timeSteps; i++) {
                storageDischargingA[i] = cplex1.numVar(minStorageFlowOutA, maxStorageFlowOutA);
            }

            IloNumVar[] stateOfChargeInStorageA = new IloNumVar[timeSteps];
            stateOfChargeInStorageA[0] = cplex1.numVar(initialChargeInStorageA, initialChargeInStorageA);
            for (int i = 1; i < timeSteps; i++) {
                stateOfChargeInStorageA[i] = cplex1.numVar(minEnergycontentStorageA, maxEnergycontentStorageA);
            }

            // defining variables for Zone B //////////////////////////////////////////////////////////////////////////////////////

            IloNumVar[] generationCapacityGasPlantB = new IloNumVar[timeSteps];
            for (int i = 0; i < timeSteps; i++) {
                generationCapacityGasPlantB[i] = cplex1.numVar(0, maxGenerationCapacityGasPlantB);
            }

            IloNumVar[] generationCapacityNuclearPlantB = new IloNumVar[timeSteps];
            for (int i = 0; i < timeSteps; i++) {
                generationCapacityNuclearPlantB[i] = cplex1.numVar(0, maxGenerationCapacityNuclearPlantB);
            }

            IloNumVar[] generationCapacityCoalPlantB = new IloNumVar[timeSteps];
            for (int i = 0; i < timeSteps; i++) {
                generationCapacityCoalPlantB[i] = cplex1.numVar(0, maxGenerationCapacityCoalPlantB);
            }

            IloNumVar[] generationCapacityWindPlantB = new IloNumVar[timeSteps];
            for (int i = 0; i < timeSteps; i++) {
                generationCapacityWindPlantB[i] = cplex1.numVar(0, availableWindCapacityB[i]);
            }

            IloNumVar[] generationCapacitySolarPlantB = new IloNumVar[timeSteps];
            for (int i = 0; i < timeSteps; i++) {
                generationCapacitySolarPlantB[i] = cplex1.numVar(0, availableSolarCapacityB[i]);
            }

            IloNumVar[] demandPerHourB = new IloNumVar[timeSteps];
            for (int i = 0; i < timeSteps; i++) {
                demandPerHourB[i] = cplex1.numVar(totalDemandB[i], totalDemandB[i]);
            }

            IloNumVar[] storageChargingB = new IloNumVar[timeSteps];
            for (int i = 0; i < timeSteps; i++) {
                storageChargingB[i] = cplex1.numVar(minStorageFlowInB, maxStorageFlowInB);
            }

            IloNumVar[] storageDischargingB = new IloNumVar[timeSteps];
            for (int i = 0; i < timeSteps; i++) {
                storageDischargingB[i] = cplex1.numVar(minStorageFlowOutB, maxStorageFlowOutB);
            }

            IloNumVar[] stateOfChargeInStorageB = new IloNumVar[timeSteps];
            stateOfChargeInStorageB[0] = cplex1.numVar(initialChargeInStorageB, initialChargeInStorageB);
            for (int i = 1; i < timeSteps; i++) {
                stateOfChargeInStorageB[i] = cplex1.numVar(minEnergycontentStorageB, maxEnergycontentStorageB);
            }

            // Market coupling (congestion management) variables /////////////////////////////////////////////////////////////////

            // A and B //////////////////////////////////////////////////////////////////////////////////////

            IloNumVar[] interconnectorCapacityAandB = new IloNumVar[timeSteps];
            // Power flow from zone A to B
            for (int i = 0; i < timeSteps; i++) {
                interconnectorCapacityAandB[i] = cplex1.numVar(maxInterCapAandB, maxInterCapAandB);
            }

            IloNumVar[] crossBorderGenerationAtoB = new IloNumVar[timeSteps];
            // Power flow from zone A to B
            for (int i = 0; i < timeSteps; i++) {
                crossBorderGenerationAtoB[i] = cplex1.numVar(minMarketCrossBorderFlowAandB, maxMarketCrossBorderFlowAandB);
            }

            IloNumVar[] crossBorderGenerationBtoA = new IloNumVar[timeSteps];
            // Power flow from zone A to B
            for (int i = 0; i < timeSteps; i++) {
                crossBorderGenerationBtoA[i] = cplex1.numVar(minMarketCrossBorderFlowAandB, maxMarketCrossBorderFlowAandB);
            }

            // defining expressions for Zone A //////////////////////////////////////////////////////////////////////////////////////

            IloLinearNumExpr[] GenerationSideA = new IloLinearNumExpr[timeSteps];
            for (int i = 0; i < timeSteps; i++) {
                GenerationSideA[i] = cplex1.linearNumExpr();
                GenerationSideA[i].addTerm(1, generationCapacityWindPlantA[i]);
                GenerationSideA[i].addTerm(1, generationCapacitySolarPlantA[i]);
                GenerationSideA[i].addTerm(1, generationCapacityGasPlantA[i]);
                GenerationSideA[i].addTerm(1, generationCapacityNuclearPlantA[i]);
                GenerationSideA[i].addTerm(1, generationCapacityCoalPlantA[i]);
                GenerationSideA[i].addTerm(1, storageDischargingA[i]);
            }

            IloLinearNumExpr[] DemandSideA = new IloLinearNumExpr[timeSteps];
            for (int i = 0; i < timeSteps; i++) {
                DemandSideA[i] = cplex1.linearNumExpr();
                DemandSideA[i].addTerm(1, demandPerHourA[i]);
                DemandSideA[i].addTerm(1, storageChargingA[i]);
            }

            IloLinearNumExpr[] GenerationEquationA = new IloLinearNumExpr[timeSteps];
            for (int i = 0; i < timeSteps; i++) {
                GenerationEquationA[i] = cplex1.linearNumExpr();
                GenerationEquationA[i].addTerm(1, generationCapacityWindPlantA[i]);
                GenerationEquationA[i].addTerm(1, generationCapacitySolarPlantA[i]);
                GenerationEquationA[i].addTerm(1, generationCapacityGasPlantA[i]);
                GenerationEquationA[i].addTerm(1, generationCapacityNuclearPlantA[i]);
                GenerationEquationA[i].addTerm(1, generationCapacityCoalPlantA[i]);
                GenerationEquationA[i].addTerm(1, storageDischargingA[i]);
                GenerationEquationA[i].addTerm(1, crossBorderGenerationBtoA[i]);
            }

            IloLinearNumExpr[] DemandEquationA = new IloLinearNumExpr[timeSteps];
            for (int i = 0; i < timeSteps; i++) {
                DemandEquationA[i] = cplex1.linearNumExpr();
                DemandEquationA[i].addTerm(1, demandPerHourA[i]);
                DemandEquationA[i].addTerm(1, storageChargingA[i]);
                DemandEquationA[i].addTerm(1, crossBorderGenerationAtoB[i]);
            }

            IloLinearNumExpr[] exprStorageContentA = new IloLinearNumExpr[timeSteps];
            for (int i = 1; i < timeSteps; i++) {
                exprStorageContentA[i] = cplex1.linearNumExpr();
                exprStorageContentA[i].addTerm(1, stateOfChargeInStorageA[i - 1]);
                exprStorageContentA[i].addTerm(nA, storageChargingA[i - 1]);
                exprStorageContentA[i].addTerm(-nInvA, storageDischargingA[i - 1]);
            }

            // defining expressions for Zone B //////////////////////////////////////////////////////////////////////////////////////

            IloLinearNumExpr[] GenerationSideB = new IloLinearNumExpr[timeSteps];
            for (int i = 0; i < timeSteps; i++) {
                GenerationSideB[i] = cplex1.linearNumExpr();
                GenerationSideB[i].addTerm(1, generationCapacityWindPlantB[i]);
                GenerationSideB[i].addTerm(1, generationCapacitySolarPlantB[i]);
                GenerationSideB[i].addTerm(1, generationCapacityGasPlantB[i]);
                GenerationSideB[i].addTerm(1, generationCapacityNuclearPlantB[i]);
                GenerationSideB[i].addTerm(1, generationCapacityCoalPlantB[i]);
                GenerationSideB[i].addTerm(1, storageDischargingB[i]);
            }

            IloLinearNumExpr[] DemandSideB = new IloLinearNumExpr[timeSteps];
            for (int i = 0; i < timeSteps; i++) {
                DemandSideB[i] = cplex1.linearNumExpr();
                DemandSideB[i].addTerm(1, demandPerHourB[i]);
                DemandSideB[i].addTerm(1, storageChargingB[i]);
            }

            IloLinearNumExpr[] GenerationEquationB = new IloLinearNumExpr[timeSteps];
            for (int i = 0; i < timeSteps; i++) {
                GenerationEquationB[i] = cplex1.linearNumExpr();
                GenerationEquationB[i].addTerm(1, generationCapacityWindPlantB[i]);
                GenerationEquationB[i].addTerm(1, generationCapacitySolarPlantB[i]);
                GenerationEquationB[i].addTerm(1, generationCapacityGasPlantB[i]);
                GenerationEquationB[i].addTerm(1, generationCapacityNuclearPlantB[i]);
                GenerationEquationB[i].addTerm(1, generationCapacityCoalPlantB[i]);
                GenerationEquationB[i].addTerm(1, storageDischargingB[i]);
                GenerationEquationB[i].addTerm(1, crossBorderGenerationAtoB[i]);
            }

            IloLinearNumExpr[] DemandEquationB = new IloLinearNumExpr[timeSteps];
            for (int i = 0; i < timeSteps; i++) {
                DemandEquationB[i] = cplex1.linearNumExpr();
                DemandEquationB[i].addTerm(1, demandPerHourB[i]);
                DemandEquationB[i].addTerm(1, storageChargingB[i]);
                DemandEquationB[i].addTerm(1, crossBorderGenerationBtoA[i]);
            }

            IloLinearNumExpr[] exprStorageContentB = new IloLinearNumExpr[timeSteps];
            for (int i = 1; i < timeSteps; i++) {
                exprStorageContentB[i] = cplex1.linearNumExpr();
                exprStorageContentB[i].addTerm(1, stateOfChargeInStorageB[i - 1]);
                exprStorageContentB[i].addTerm(nB, storageChargingB[i - 1]);
                exprStorageContentB[i].addTerm(-nInvB, storageDischargingB[i - 1]);
            }

            // OBJECTIVE FUNCTION EXPRESSION //////////////////////////////////////////////////////////////////////////////////

            IloLinearNumExpr objective = cplex1.linearNumExpr();
            for (int i = 0; i < timeSteps; ++i) {
                objective.addTerm(marginalCostGasPlantA, generationCapacityGasPlantA[i]);
                objective.addTerm(marginalCostNuclearPlantA, generationCapacityNuclearPlantA[i]);
                objective.addTerm(marginalCostCoalPlantA, generationCapacityCoalPlantA[i]);
                objective.addTerm(marginalCostGasPlantB, generationCapacityGasPlantB[i]);
                objective.addTerm(marginalCostNuclearPlantB, generationCapacityNuclearPlantB[i]);
                objective.addTerm(marginalCostCoalPlantB, generationCapacityCoalPlantB[i]);
            }

            // defining objective

            cplex1.addMinimize(objective);

            // defining constraints for Zone A

            for (int i = 0; i < timeSteps; ++i) {
                cplex1.addEq(GenerationEquationA[i], DemandEquationA[i]);
            }

            cplex1.addEq(stateOfChargeInStorageA[0], initialChargeInStorageA);

            cplex1.addLe(storageDischargingA[0], stateOfChargeInStorageA[0]);

            for (int i = 1; i < timeSteps; i++) {
                cplex1.addLe(storageDischargingA[i], cplex1.prod(nA, stateOfChargeInStorageA[i]));
            }

            for (int i = 1; i < timeSteps; i++) {
                cplex1.addEq(exprStorageContentA[i], stateOfChargeInStorageA[i]);
            }

            // defining constraints for Zone B

            for (int i = 0; i < timeSteps; ++i) {
                cplex1.addEq(GenerationEquationB[i], DemandEquationB[i]);
            }

            cplex1.addEq(stateOfChargeInStorageB[0], initialChargeInStorageB);

            cplex1.addLe(storageDischargingB[0], stateOfChargeInStorageB[0]);

            for (int i = 1; i < timeSteps; i++) {
                cplex1.addLe(storageDischargingB[i], cplex1.prod(nB, stateOfChargeInStorageB[i]));
            }

            for (int i = 1; i < timeSteps; i++) {
                cplex1.addEq(exprStorageContentB[i], stateOfChargeInStorageB[i]);
            }

            // defining constraints for market coupling

            /*for (int i = 0; i < timeSteps; i++) {
                cplex1.addLe(cplex1.diff(GenerationSideA[i], DemandSideA[i]), crossBorderGenerationAtoB[i]);
            }

            for (int i = 0; i < timeSteps; i++) {
                cplex1.addLe(cplex1.diff(GenerationSideB[i], DemandSideB[i]), crossBorderGenerationBtoA[i]);
            }

            for (int i = 0; i < timeSteps; i++) {
                cplex1.addLe(cplex1.sum(crossBorderGenerationAtoB[i], crossBorderGenerationBtoA[i]), interconnectorCapacityAandB[i]);
            }*/

            cplex1.setParam(IloCplex.IntParam.Simplex.Display, 0);

            // solve

            if (cplex1.solve()) {
                System.out.println("----------------------------------------------------------");
                System.out.println("Objective = " + cplex1.getObjValue());
                System.out.println("Objective = " + cplex1.getStatus());
                System.out.println("---------------------Market Opens-------------------------");

                for (int i = 0; i < timeSteps; ++i) {
                    System.out.println("----------------------Time Step " + (i + 1) + "-------------------------");
                    System.out.println("------------------------ZONE A-------------------------");
                    System.out.println("Generation Capacity of Gas Plant A    = " + cplex1.getValue(generationCapacityGasPlantA[i]));
                    System.out.println("Generation Capacity of Nuclear Plant A = " + cplex1.getValue(generationCapacityNuclearPlantA[i]));
                    System.out.println("Generation Capacity of Coal Plant A   = " + cplex1.getValue(generationCapacityCoalPlantA[i]));
                    System.out.println("Generation Capacity of Wind Plant A   = " + cplex1.getValue(generationCapacityWindPlantA[i]));
                    System.out.println("Generation Capacity of Solar Plant A  = " + cplex1.getValue(generationCapacitySolarPlantA[i]));
                    System.out.println("Cross Border Generation from B to A  = " + cplex1.getValue(crossBorderGenerationBtoA[i]));
                    System.out.println("*******************************");
                    System.out.println("Storage Charging A  = " + cplex1.getValue(storageChargingA[i]));
                    System.out.println("Storage Discharging A  = " + cplex1.getValue(storageDischargingA[i]));
                    System.out.println("State of Charge in Storage A  = " + cplex1.getValue(stateOfChargeInStorageA[i]));
                    System.out.println("*******************************");
                    System.out.println("-------------------------------");
                    System.out.println("Total Generation A =  " + cplex1.getValue(GenerationSideA[i]));
                    System.out.println("Total Demand A =  " + cplex1.getValue(DemandSideA[i]));
                    System.out.println("-------------------------------");

                    System.out.println("------------------------ZONE B-------------------------");
                    System.out.println("Generation Capacity of Gas Plant B    = " + cplex1.getValue(generationCapacityGasPlantB[i]));
                    System.out.println("Generation Capacity of Nuclear Plant B = " + cplex1.getValue(generationCapacityNuclearPlantB[i]));
                    System.out.println("Generation Capacity of Coal Plant B   = " + cplex1.getValue(generationCapacityCoalPlantB[i]));
                    System.out.println("Generation Capacity of Wind Plant B   = " + cplex1.getValue(generationCapacityWindPlantB[i]));
                    System.out.println("Generation Capacity of Solar Plant B  = " + cplex1.getValue(generationCapacitySolarPlantB[i]));
                    System.out.println("Cross Border Generation from A to B  = " + cplex1.getValue(crossBorderGenerationAtoB[i]));
                    System.out.println("*******************************");
                    System.out.println("Storage Charging B  = " + cplex1.getValue(storageChargingB[i]));
                    System.out.println("Storage Discharging B  = " + cplex1.getValue(storageDischargingB[i]));
                    System.out.println("State of Charge in Storage B  = " + cplex1.getValue(stateOfChargeInStorageB[i]));
                    System.out.println("*******************************");
                    System.out.println("-------------------------------");
                    System.out.println("Total Generation B =  " + cplex1.getValue(GenerationSideB[i]));
                    System.out.println("Total Demand B =  " + cplex1.getValue(DemandSideB[i]));
                    System.out.println("-------------------------------");

                }
            } else {
                System.out.println("Something went wrong");
            }
            cplex1.end();
        } catch (IloException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }


    // public void populate_plantValues(ArrayList<Plant> pp) {
    //
    // readInput();
    //
    // int timeSteps = totalDemand.length;
    //
    // for (Plant p : pp) {
    //
    // if (p.getZone().equals("Zone Country A") &&
    // p.getTechnology().equals("Wind")) {
    //
    // ArrayList<Double> availableWindPlantCapacity = new
    // ArrayList<Double>(timeSteps);
    //
    // for (int i = 0; i < timeSteps; i++)
    //
    // {
    // availableWindPlantCapacity.add(i, p.getActualNominalCapacity() *
    // WindSpeed[i]);
    // }
    // p.setAvailableRESCapacity(availableWindPlantCapacity);
    // }
    //
    // else if (p.getZone().equals("Zone Country A") &&
    // p.getTechnology().equals("Photovoltaic")) {
    //
    // ArrayList<Double> availableSolarPlantCapacity = new
    // ArrayList<Double>(timeSteps);
    //
    // for (int i = 0; i < timeSteps; i++)
    //
    // {
    // availableSolarPlantCapacity.add(i, p.getActualNominalCapacity() *
    // SolarIrradiance[i]);
    // }
    // p.setAvailableRESCapacity(availableSolarPlantCapacity);
    // }
    //
    // else if (p.getZone().equals("Zone Country B") &&
    // p.getTechnology().equals("Wind")) {
    //
    // ArrayList<Double> availableWindPlantCapacity = new
    // ArrayList<Double>(timeSteps);
    //
    // for (int i = 0; i < timeSteps; i++)
    //
    // {
    // availableWindPlantCapacity.add(i, p.getActualNominalCapacity() *
    // WindSpeed[i]);
    // }
    // p.setAvailableRESCapacity(availableWindPlantCapacity);
    // }
    //
    // else if (p.getZone().equals("Zone Country B") &&
    // p.getTechnology().equals("Photovoltaic")) {
    //
    // ArrayList<Double> availableSolarPlantCapacity = new
    // ArrayList<Double>(timeSteps);
    //
    // for (int i = 0; i < timeSteps; i++)
    //
    // {
    // availableSolarPlantCapacity.add(i, p.getActualNominalCapacity() *
    // SolarIrradiance[i]);
    // }
    // p.setAvailableRESCapacity(availableSolarPlantCapacity);
    // }
    // }
    // run_optimization(pp);
    // }
    //
    // // ArrayList<IloNumVar[]> generationCapacityPlantArrayList = new
    // // ArrayList<IloNumVar[]>();
    //
    // public void run_optimization(ArrayList<Plant> pp) {
    // Timer hourlyTimerMarket = new Timer();
    // hourlyTimerMarket.start();
    //
    // System.out.println("----------------------------------------------------------");
    // System.out.println("Starting optimization model");
    // System.out.println(totalDemand.length);
    //
    // int timeSteps = totalDemand.length;
    //
    // System.gc();
    //
    // try {
    // IloCplex cplex = new IloCplex();
    //
    // Iterable<DecarbonizationMarket> marketList = new
    // ArrayList<DecarbonizationMarket>();
    // marketList = reps.marketRepository.findAll();
    //
    // for (DecarbonizationMarket market : reps.marketRepository.findAll()) {
    // Iterable<PpdpAnnual> ppdpAnnualList = reps.ppdpAnnualRepository
    // .findAllSubmittedPpdpAnnualForGivenMarketAndTime(market,
    // getCurrentTick());
    //
    // }
    //
    // /*
    // * Iterable<PowerPlantDispatchPlan> sortedListofPPDP =
    // * plantDispatchPlanRepository
    // * .findDescendingSortedPowerPlantDispatchPlansForSegmentForTime(
    // * currentSegment, getCurrentTick(), false);
    // *
    // * for (PowerPlantDispatchPlan currentPPDP: sortedListofPPDP){
    // */
    //
    // for (Plant p : pp) {
    //
    // ArrayList<IloNumVar> generationCapacityOfPlant = new
    // ArrayList<IloNumVar>(timeSteps);
    //
    // for (int i = 0; i < timeSteps; i++) {
    //
    // if (p.getZone().equals("Zone Country A") &&
    // p.getTechnology().equals("Wind")) {
    //
    // generationCapacityOfPlant.add(i, cplex.numVar(0,
    // p.getAvailableRESCapacity().get(i)));
    // }
    //
    // else if (p.getZone().equals("Zone Country A") &&
    // p.getTechnology().equals("Photovoltaic")) {
    //
    // generationCapacityOfPlant.add(i, cplex.numVar(0,
    // p.getAvailableRESCapacity().get(i)));
    //
    // }
    // if (p.getZone().equals("Zone Country B") &&
    // p.getTechnology().equals("Wind")) {
    //
    // generationCapacityOfPlant.add(i, cplex.numVar(0,
    // p.getAvailableRESCapacity().get(i)));
    // }
    //
    // else if (p.getZone().equals("Zone Country B") &&
    // p.getTechnology().equals("Photovoltaic")) {
    //
    // generationCapacityOfPlant.add(i, cplex.numVar(0,
    // p.getAvailableRESCapacity().get(i)));
    //
    // } else {
    // generationCapacityOfPlant.add(i, cplex.numVar(0,
    // p.getActualNominalCapacity()));
    // }
    // }
    // p.setGenerationCapacityOfPlant(generationCapacityOfPlant);
    // }
    //
    // // defining variables for Country A
    //
    // IloNumVar[] demandPerHourA = new IloNumVar[timeSteps];
    // for (int i = 0; i < timeSteps; i++) {
    // demandPerHourA[i] = cplex.numVar(totalDemand[i], totalDemand[i]);
    // }
    //
    // IloNumVar[] storageChargingA = new IloNumVar[timeSteps];
    // for (int i = 0; i < timeSteps; i++) {
    // storageChargingA[i] = cplex.numVar(minStorageFlowInA, maxStorageFlowInA);
    // }
    //
    // IloNumVar[] storageDischargingA = new IloNumVar[timeSteps];
    // for (int i = 0; i < timeSteps; i++) {
    // storageDischargingA[i] = cplex.numVar(minStorageFlowOutA,
    // maxStorageFlowOutA);
    // }
    //
    // IloNumVar[] stateOfChargeInStorageA = new IloNumVar[timeSteps];
    // stateOfChargeInStorageA[0] = cplex.numVar(initialChargeInStorageA,
    // initialChargeInStorageA);
    // for (int i = 1; i < timeSteps; i++) {
    // stateOfChargeInStorageA[i] = cplex.numVar(minEnergycontentStorageA,
    // maxEnergycontentStorageA);
    // }
    //
    // // defining variables for Country B
    //
    // IloNumVar[] demandPerHourB = new IloNumVar[timeSteps];
    // for (int i = 0; i < timeSteps; i++) {
    // demandPerHourB[i] = cplex.numVar(totalDemand[i], totalDemand[i]);
    // }
    //
    // IloNumVar[] storageChargingB = new IloNumVar[timeSteps];
    // for (int i = 0; i < timeSteps; i++) {
    // storageChargingB[i] = cplex.numVar(minStorageFlowInB, maxStorageFlowInB);
    // }
    //
    // IloNumVar[] storageDischargingB = new IloNumVar[timeSteps];
    // for (int i = 0; i < timeSteps; i++) {
    // storageDischargingB[i] = cplex.numVar(minStorageFlowOutB,
    // maxStorageFlowOutB);
    // }
    //
    // IloNumVar[] stateOfChargeInStorageB = new IloNumVar[timeSteps];
    // stateOfChargeInStorageB[0] = cplex.numVar(initialChargeInStorageB,
    // initialChargeInStorageB);
    // for (int i = 1; i < timeSteps; i++) {
    // stateOfChargeInStorageB[i] = cplex.numVar(minEnergycontentStorageB,
    // maxEnergycontentStorageB);
    // }
    //
    // // Market coupling (congestion management) variables
    //
    // IloNumVar[] interconnectorCapacityAandB = new IloNumVar[timeSteps];
    // for (int i = 0; i < timeSteps; i++) {
    // interconnectorCapacityAandB[i] = cplex.numVar(maxInterCapAandB,
    // maxInterCapAandB);
    // }
    //
    // IloNumVar[] crossBorderGenerationAtoB = new IloNumVar[timeSteps];
    // // Power flow from zone A to B
    // for (int i = 0; i < timeSteps; i++) {
    // crossBorderGenerationAtoB[i] =
    // cplex.numVar(minMarketCrossBorderFlowAandB,
    // maxMarketCrossBorderFlowAandB);
    // }
    //
    // IloNumVar[] crossBorderGenerationBtoA = new IloNumVar[timeSteps];
    // // Power flow from zone B to A
    // for (int i = 0; i < timeSteps; i++) {
    // crossBorderGenerationBtoA[i] =
    // cplex.numVar(minMarketCrossBorderFlowAandB,
    // maxMarketCrossBorderFlowAandB);
    // }
    //
    // // defining expressions for Country A
    //
    // IloLinearNumExpr[] GenerationSideA = new IloLinearNumExpr[timeSteps];
    // for (int i = 0; i < timeSteps; i++) {
    // GenerationSideA[i] = cplex.linearNumExpr();
    // for (Plant p : pp) {
    // if (p.getZone().equals("Zone Country A")) {
    // GenerationSideA[i].addTerm(1, p.getGenerationCapacityOfPlant().get(i));
    // }
    // }
    // GenerationSideA[i].addTerm(1, storageDischargingA[i]);
    // GenerationSideA[i].addTerm(1, crossBorderGenerationBtoA[i]);
    // }
    //
    // IloLinearNumExpr[] DemandSideA = new IloLinearNumExpr[timeSteps];
    // for (int i = 0; i < timeSteps; i++) {
    // DemandSideA[i] = cplex.linearNumExpr();
    // DemandSideA[i].addTerm(1, demandPerHourA[i]);
    // DemandSideA[i].addTerm(1, storageChargingA[i]);
    // DemandSideA[i].addTerm(1, crossBorderGenerationAtoB[i]);
    // }
    //
    // IloLinearNumExpr[] exprStorageContentA = new IloLinearNumExpr[timeSteps];
    // for (int i = 1; i < timeSteps; i++) {
    // exprStorageContentA[i] = cplex.linearNumExpr();
    // exprStorageContentA[i].addTerm(1, stateOfChargeInStorageA[i - 1]);
    // exprStorageContentA[i].addTerm(nA, storageChargingA[i]);
    // exprStorageContentA[i].addTerm(-nInvA, storageDischargingA[i]);
    // }
    //
    // // defining expressions for Country B
    //
    // IloLinearNumExpr[] GenerationSideB = new IloLinearNumExpr[timeSteps];
    // for (int i = 0; i < timeSteps; i++) {
    // GenerationSideB[i] = cplex.linearNumExpr();
    // for (Plant p : pp) {
    // if (p.getZone().equals("Zone Country B")) {
    // GenerationSideB[i].addTerm(1, p.getGenerationCapacityOfPlant().get(i));
    // }
    // }
    // GenerationSideB[i].addTerm(1, storageDischargingA[i]);
    // GenerationSideB[i].addTerm(1, crossBorderGenerationAtoB[i]);
    // }
    //
    // IloLinearNumExpr[] DemandSideB = new IloLinearNumExpr[timeSteps];
    // for (int i = 0; i < timeSteps; i++) {
    // DemandSideB[i] = cplex.linearNumExpr();
    // DemandSideB[i].addTerm(1, demandPerHourA[i]);
    // DemandSideB[i].addTerm(1, storageChargingA[i]);
    // DemandSideB[i].addTerm(1, crossBorderGenerationBtoA[i]);
    // }
    //
    // IloLinearNumExpr[] exprStorageContentB = new IloLinearNumExpr[timeSteps];
    // for (int i = 1; i < timeSteps; i++) {
    // exprStorageContentB[i] = cplex.linearNumExpr();
    // exprStorageContentB[i].addTerm(1, stateOfChargeInStorageB[i - 1]);
    // exprStorageContentB[i].addTerm(nB, storageChargingB[i]);
    // exprStorageContentB[i].addTerm(-nInvB, storageDischargingB[i]);
    // }
    //
    // // OBJECTIVE FUNCTION EXPRESSION
    //
    // Iterable<PpdpAnnual> allSubmittedPpdpAnnuals =
    // reps.ppdpAnnualRepository.findAllSubmittedPpdpAnnualForGivenTime(getCurrentTick());
    //
    // IloLinearNumExpr objective = cplex.linearNumExpr();
    // for (int i = 0; i < timeSteps; ++i) {
    // for (PpdpAnnual p : allSubmittedPpdpAnnuals) {
    // objective.addTerm(p.getPrice(),
    // p.getAvailableHourlyAmount().getHourlyArray(i));
    // }
    // }
    //
    // // defining objective
    //
    // cplex.addMinimize(objective);
    //
    // // defining constraints for Country A
    //
    // for (int i = 0; i < timeSteps; ++i) {
    // cplex.addEq(GenerationSideA[i], DemandSideA[i]);
    // }
    //
    // cplex.addEq(stateOfChargeInStorageA[0], initialChargeInStorageA);
    //
    // cplex.addLe(storageDischargingA[0], stateOfChargeInStorageA[0]);
    //
    // for (int i = 1; i < timeSteps; i++) {
    // cplex.addLe(storageDischargingA[i], cplex.prod(nA,
    // stateOfChargeInStorageA[i]));
    // }
    //
    // for (int i = 1; i < timeSteps; i++) {
    // cplex.addEq(exprStorageContentA[i], stateOfChargeInStorageA[i]);
    // }
    //
    // // defining constraints for Country B
    //
    // for (int i = 0; i < timeSteps; ++i) {
    // cplex.addEq(GenerationSideB[i], DemandSideB[i]);
    // }
    //
    // cplex.addEq(stateOfChargeInStorageB[0], initialChargeInStorageB);
    //
    // cplex.addLe(storageDischargingB[0], stateOfChargeInStorageB[0]);
    //
    // for (int i = 1; i < timeSteps; i++) {
    // cplex.addLe(storageDischargingB[i], cplex.prod(nB,
    // stateOfChargeInStorageB[i]));
    // }
    //
    // for (int i = 1; i < timeSteps; i++) {
    // cplex.addEq(exprStorageContentB[i], stateOfChargeInStorageB[i]);
    // }
    //
    // // solve
    //
    // if (cplex.solve()) {
    // System.out.println("----------------------------------------------------------");
    // System.out.println("Objective = " + cplex.getObjValue());
    // System.out.println("Objective = " + cplex.getStatus());
    // System.out.println("---------------------Market
    // Cleared-----------------------");
    //
    // for (int i = 0; i < timeSteps; i++) {
    // for (Plant p : pp) {
    // System.out.println(
    // "Generation Capacity: " +
    // cplex.getValue(p.getGenerationCapacityOfPlant().get(i)));
    // }
    // System.out.println("Time Step over:" + i
    // +
    // "-------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
    //
    // }
    // for (int i = 0; i < timeSteps; i++) {
    // System.out.println(
    // "Cross Border Generation from B to A = " +
    // cplex.getValue(crossBorderGenerationBtoA[i]));
    // System.out.println(
    // "Cross Border Generation from A to B = " +
    // cplex.getValue(crossBorderGenerationAtoB[i]));
    // }
    //
    //
    //
    // } else {
    // System.out.println("Something went wrong");
    // }
    // cplex.end();
    //
    //
    // hourlyTimerMarket.stop();
    // System.out.println("Optimization took: " + hourlyTimerMarket.seconds() +
    // " seconds");
    // System.exit(0);
    // } catch (IloException e) {
    // // TODO Auto-generated catch block
    // e.printStackTrace();
    // }
    //
    // }

}
