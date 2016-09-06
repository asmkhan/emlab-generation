/*******************************************************************************
 * Copyright 2012 the original author or authors.
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
package emlab.gen.domain.market.electricity;

import org.springframework.data.neo4j.annotation.NodeEntity;

@NodeEntity
public class YearlySegment {

    private double yearlySegmentLengthInHours;

    public double getYearlySegmentLengthInHours() {
        return yearlySegmentLengthInHours;
    }

    public void setYearlySegmentLengthInHours(double yearlySegmentLengthInHours) {
        this.yearlySegmentLengthInHours = yearlySegmentLengthInHours;
    }

    public int getYearlySegmentID() {
        return yearlySegmentID;
    }

    public void setYearlySegmentID(int yearlySegmentID) {
        this.yearlySegmentID = yearlySegmentID;
    }

    private int yearlySegmentID;

    /**
     * Should be 8760 hours long, and only one TRUE value for each index over
     * all segments.
     */
    // private boolean[] representsHoursOfTheYear;

    // @Override
    // public double getLengthInHours() {
    // return lengthInHours;
    // }
    //
    // @Override
    // public void setLengthInHours(double lengthInHours) {
    // this.lengthInHours = lengthInHours;
    // // this.persist();
    // }

    // public boolean[] getRepresentsHoursOfTheYear() {
    // return representsHoursOfTheYear;
    // }

    // public void setRepresentsHoursOfTheYear(boolean[]
    // representsHoursOfTheYear) {
    // this.representsHoursOfTheYear = representsHoursOfTheYear;
    // }

    // public int getSegmentID() {
    // return segmentID;
    // }
    //
    // public void setSegmentID(int segmentID) {
    // this.segmentID = segmentID;
    // }

    @Override
    public String toString() {
        return "length in hours: " + getYearlySegmentLengthInHours();
    }

}