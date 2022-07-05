import {useState, useEffect} from 'react';
import styled from 'styled-components'
import {useTranslation} from "react-i18next";
import Metric from 'types/Metric';
import GroupMetricsService from 'api/modules/GroupMetricsService';
import MetricsService from 'api/modules/MetricsService';
import AppPaper from 'components/AppPaper'
import AppLineChart from 'components/AppLineChart';
import AppButton from 'components/AppButton';
import MetricForm from 'components/MetricForm';
import GroupMetricsFilters, {iFilters} from 'components/GroupMetricsFilters';
import {getCurrentDate, formatDateBasic} from 'utils/date'

const groupMetricsService = new GroupMetricsService()
const metricsService = new MetricsService()

const createEmptyMetric = () => ({
  name: '',
  value: 0,
  timestamp: formatDateBasic(getCurrentDate())
})

function Home() {
  const [groupMetrics, setGroupMetrics] = useState<{[key: string]: [value: string]}>({})
  const [ready, setReady] = useState(false)
  const [filters, setFilters] = useState<iFilters>(null as any)
  const [metricErrors, setMetricErrors] = useState({})
  const [metric, setMetric] = useState<Metric>(createEmptyMetric())
  const {t} = useTranslation();

  const submitMetric = async (metric: Metric) => {
    const {errors} = await metricsService.create(metric)

    setMetricErrors(errors)

    if (!errors) {
      setMetric({...createEmptyMetric()})
      fetchData()
    }
  }

  const fetchData = async () => {
    const {data} = await groupMetricsService.index({
      group_by: filters.groupBy,
      filter: {
        datetime_from: filters.datetimeFrom,
        datetime_until: filters.datetimeUntil
      }
    })

    setGroupMetrics(data)
  }

  useEffect(() => {
    if (!filters || ready) { return }

    setReady(true)

    fetchData()
  }, [ready, filters])

  return (
    <div>
      <AppPaper title={t('metricForm')}>
        <MetricForm
          metric={metric}
          onSubmit={submitMetric}
          errors={metricErrors}
        />
      </AppPaper>

      <AppPaper title={t('filtersGroupMetrics')}>
        <GroupMetricsFilters onFiltersChanged={setFilters} />

        <ActionContainer>
          <AppButton
            onClick={fetchData}
            label={t('search')}
          />
        </ActionContainer>
      </AppPaper>

      <AppLineChart data={groupMetrics} />
    </div>
  );
}

const ActionContainer = styled.div`
  display: flex;
  flex-direction: row-reverse;
`

export default Home;
