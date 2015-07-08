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

import emlab.gen.domain.agent.TargetInvestor;
import emlab.gen.domain.market.electricity.ElectricitySpotMarket;

/**
 * @author JCRichstein
 * 
 */

public interface TargetInvestorRepository extends GraphRepository<TargetInvestor> {

    @Query(value = "g.idx('__types__')[[className:'emlab.gen.domain.agent.TargetInvestor']].as('x').out('INVESTOR_MARKET').idFilter(market, FilterPipe.Filter.EQUAL).back('x')", type = QueryType.Gremlin)
    Iterable<TargetInvestor> findAllByMarket(@Param("market") ElectricitySpotMarket electricitySpotMarket);

    @Query(value = "result = g.v(market).in('INVESTOR_MARKET').next(); ; if(!result.hasNext()){return null;} else{return result.next();}", type = QueryType.Gremlin)
    TargetInvestor findOneByMarket(@Param("market") ElectricitySpotMarket electricitySpotMarket);

    @Query(value = "result = g.v(market).in('INVESTOR_MARKET').next();", type = QueryType.Gremlin)
    TargetInvestor findInvestorByMarket(@Param("market") ElectricitySpotMarket electricitySpotMarket);

    @Query(value = "result = g.v(market).in('INVESTOR_MARKET').filter{it.__type__=='emlab.gen.domain.agent.TargetInvestor'};", type = QueryType.Gremlin)
    TargetInvestor findTargetInvestorByMarket(@Param("market") ElectricitySpotMarket electricitySpotMarket);

}
