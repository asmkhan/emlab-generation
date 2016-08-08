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
package emlab.gen.repository;

import org.springframework.data.neo4j.annotation.Query;
import org.springframework.data.neo4j.annotation.QueryType;
import org.springframework.data.neo4j.repository.GraphRepository;
import org.springframework.data.repository.query.Param;

import emlab.gen.domain.market.electricity.YearlySegment;
import emlab.gen.domain.technology.Interconnector;

public interface InterconnectorRepository extends GraphRepository<Interconnector> {

    // @Query(value =
    // "g.v(plant).out('LOCATION').out('REGION').in('GOVERNED_ZONE').next()",
    // type = QueryType.Gremlin)
    // NationalGovernment findNationalGovernmentByPowerPlant(@Param("plant")
    // PowerPlant plant);

    // @Query(value = "g.v(market).out('ZONE').in('GOVERNED_ZONE').next()", type
    // = QueryType.Gremlin)
    // NationalGovernment
    // findNationalGovernmentByElectricitySpotMarket(@Param("market")
    // ElectricitySpotMarket market);

    @Query(value = "g.idx('__types__')[[className:'emlab.gen.domain.technology.Interconnector']].capacity", type = QueryType.Gremlin)
    public double findInterconnectorCapacity();

    @Query(value = "g.v(interconnector).out('YEARLYSEGMENT_INTERCONNECTOR').filter{it.__type__=='emlab.gen.domain.market.electricity.YearlySegment'}", type = QueryType.Gremlin)
    public YearlySegment findYearlySegmentForInterconnectorForTime(
            @Param("interconnector") Interconnector interconnector);

    @Query(value = "start interconnector=node:__types__(\"className:emlab.gen.domain.technology.Interconnector\") return interconnector")
    public Iterable<Interconnector> findAllInterconnectors();

    @Query(value = "start interconnector=node:__types__(\"className:emlab.gen.domain.technology.Interconnector\") return count(interconnector)")
    double countAllInterconnectors();

}
